import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class RoomBookingBloc extends Bloc<BookingEvent, BookingState> {
  RoomBookingBloc() : super(BookingInitial()) {
    on<SelectBookingDatesEvent>(_selectBookingDates);
  }
  final Map<String, dynamic> _bookingDetails = {};

  _selectBookingDates(
      SelectBookingDatesEvent event, Emitter<BookingState> emit) {
    _bookingDetails['check_in'] = event.checkin;
    _bookingDetails['check_out'] = event.checkout;
    _bookingDetails['dayCount'] = event.numberOfDays;
    emit(BookingFieldFilledState(bookingData: _bookingDetails));
  }
}
/*
    address
      phone
      place
      adult
      check_in
      check_out
      roomCount     (body)       pass token usertoken
      dayPrice
      location
      price
      dayCount
      type
      total
      roomId
      vendorId
 */