import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/models/booking_date_model.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/repositories/room_booking_repo.dart';
import 'package:east_stay/repositories/room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class RoomBookingBloc extends Bloc<BookingEvent, BookingState> {
  RoomBookingBloc(this._bookedRoomBloc) : super(BookingInitial()) {
    on<SelectBookingDatesEvent>(_selectBookingDates);
    on<ApplyDiscountEvent>(_applyDiscount);
    on<UpdateGuestEvent>(_updateGuest);
    on<UpdateRoomEvent>(_updateRoom);
    on<RoomEnquiryEvent>(_roomEnquiry);
    on<SetRoomEvent>(_setBookedRoom);
    on<ResetBookingEvent>(_resetBookings);
    on<BookRoomEvent>(_bookRoomEvent);
    on<PaymentFailedEvent>(_paymentFailed);
  }
  final Map<String, dynamic> _bookingDetails = {};
  Map<String, dynamic> bookingData = {};
  final BookedRoomBloc _bookedRoomBloc;

  _selectBookingDates(
      SelectBookingDatesEvent event, Emitter<BookingState> emit) {
    _bookingDetails['check_in'] = event.checkin;
    _bookingDetails['check_out'] = event.checkout;
    _bookingDetails['dayCount'] = event.numberOfDays;
    emit(BookingFieldFilledState(bookingData: _bookingDetails));
  }

  _applyDiscount(ApplyDiscountEvent event, Emitter<BookingState> emit) {
    _bookingDetails['discount'] = event.discount;
    emit(BookingFieldFilledState(bookingData: _bookingDetails));
  }

  _updateGuest(UpdateGuestEvent event, Emitter<BookingState> emit) {
    _bookingDetails['guestCount'] = event.count;
    emit(BookingFieldFilledState(bookingData: _bookingDetails));
  }

  _updateRoom(UpdateRoomEvent event, Emitter<BookingState> emit) {
    _bookingDetails['roomCount'] = event.count;
    emit(BookingFieldFilledState(bookingData: _bookingDetails));
  }

  _roomEnquiry(RoomEnquiryEvent event, Emitter<BookingState> emit) async {
    if (_bookingDetails['check_in'] == null ||
        _bookingDetails['check_out'] == null) {
      emit(BookingFailedState(message: 'Pick check-in & check-out dates'));
      return;
    }

    final checkIn = DateTime.parse(_bookingDetails['check_in']);
    final checkOut = DateTime.parse(_bookingDetails['check_out']);
    emit(BookingLoadingState());
    final either = await RoomRepo().getAvailableDates(event.roomId);
    either.fold((error) {}, (response) {
      final rawDates = response['dates'] as List;
      final dates = rawDates.map((e) => BookingDate.fromJson(e)).toList();

      bool isAvailable = true;

      for (var bookedDate in dates) {
        final bookedCheckIn = bookedDate.checkIn;
        final bookedCheckOut = bookedDate.checkOut;

        if (checkIn.isBefore(bookedCheckOut) &&
            checkOut.isAfter(bookedCheckIn)) {
          isAvailable = false;
          break;
        }
      }
      if (isAvailable) {
        add(SetRoomEvent(
            mobileNumber: event.mobileNumber,
            address: event.address,
            hotel: event.hotel));
      } else {
        emit(BookingDateNotAvailableState());
      }
    });
  }

  _setBookedRoom(SetRoomEvent event, Emitter<BookingState> emit) async {
    _bookingDetails['address'] = event.address;
    _bookingDetails['phone'] = event.mobileNumber;
    bookingData = {
      'address': event.address,
      'phone': event.mobileNumber,
      'place': 'Kollam',
      'adult': event.hotel.price,
      'check_in': _bookingDetails['check_in'],
      'check_out': _bookingDetails['check_out'],
      'roomCount': _bookingDetails['roomCount'] ?? '1',
      'dayPrice': event.hotel.price,
      'dayCount': _bookingDetails['dayCount'] ?? '1',
      'location': event.hotel.city,
      'price': event.hotel.price,
      'type': event.hotel.category,
      'total': getTotal(_bookingDetails, event.hotel.price),
      'roomId': event.hotel.id,
      'vendorId': event.hotel.vendor.id,
    };

    emit(RoomAvailableState(bookingData: bookingData));
  }

  _resetBookings(ResetBookingEvent event, Emitter<BookingState> emit) {
    _bookingDetails.clear;
    emit(BookingInitial());
  }

  String getTotal(Map<String, dynamic> bookingData, String rent) {
    final num days = bookingData['dayCount'] ?? 1;
    final guests = int.parse(bookingData['guestCount'] ?? '1');
    final rooms = int.parse(bookingData['roomCount'] ?? '1');
    final discount = int.parse(bookingData['discount'] ?? '0');
    final price = rent;
    final total = (days * guests * rooms * int.parse(price)) - discount;
    return total.toString();
  }

  _bookRoomEvent(BookRoomEvent event, Emitter<BookingState> emit) async {
    final either = await RoomBookingRepo().bookRoom(bookingData);
    either.fold((error) {
      emit(RoomBookingFailedState());
    }, (response) {
      if (response['status'] == 'success') {
        _bookedRoomBloc.add(FetchBookedRoomsEvent());
        emit(RoomBookedSuccessState());
        _bookingDetails.clear();
        emit(BookingInitial());
      } else {
        emit(RoomBookingFailedState());
      }
    });
  }

  _paymentFailed(PaymentFailedEvent event, Emitter<BookingState> emit) {
    emit(RoomBookingFailedState());
  }
}
