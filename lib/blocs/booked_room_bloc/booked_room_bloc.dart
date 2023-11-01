import 'package:east_stay/models/booked_room_model.dart';
import 'package:east_stay/repositories/room_booking_repo.dart';
import 'package:east_stay/repositories/room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booked_room_event.dart';
part 'booked_room_state.dart';

class BookedRoomBloc extends Bloc<BookedRoomEvent, BookedRoomState> {
  BookedRoomBloc() : super(BookedRoomInitial()) {
    on<FetchBookedRoomsEvent>(_fetchBookedRoom);
    on<RateBookedRoomsEvent>(_rateBookedRoom);
    on<CancelBookedRoomsEvent>(_cancelRoom);
  }

  List<BookedRoom> bookedRooms = [];
  List<BookedRoom> upcomingBookings = [];

  _fetchBookedRoom(
      FetchBookedRoomsEvent event, Emitter<BookedRoomState> emit) async {
    emit(BookedRoomLoadingState());
    final either = await RoomRepo().getBookedHotels();
    either.fold(
      (error) {
        emit(BookedRoomFetchedErrorState(message: error.message));
      },
      (response) {
        if (response['status'] == 'failed') return;
        final List rawList = response['bookedRooms'];

        bookedRooms = rawList.map((e) => BookedRoom.fromJson(e)).toList();
        upcomingBookings = bookedRooms
            .where((e) => e.checkIn.isAfter(DateTime.now()))
            .toList();
        emit(
          BookedRoomFetchedState(
            bookedrooms: bookedRooms,
            upcomingBookings: bookedRooms,
          ),
        );
      },
    );
  }

  _rateBookedRoom(
      RateBookedRoomsEvent event, Emitter<BookedRoomState> emit) async {
    final rating = {
      'roomId': event.roomId,
      'feedback': event.feedback,
      'stars': event.stars,
      'vendorId': event.vendorId
    };

    final either = await RoomRepo().rateARoom(rating);

    either.fold((error) {
      emit(RoomRatedFailedState());
    }, (response) {
      if (response['status'] == 'success') {
        emit(RoomRatedSuccessState());
      } else {
        emit(RoomRatedFailedState());
      }
    });

    emit(BookedRoomFetchedState(
        bookedrooms: bookedRooms, upcomingBookings: upcomingBookings));
  }

  _cancelRoom(
      CancelBookedRoomsEvent event, Emitter<BookedRoomState> emit) async {
    final bookId = {'bookId': event.bookId};
    final either = await RoomBookingRepo().cancelRoom(bookId);
    either.fold((error) {
      emit(RoomCancelFailedState(message: error.message));
    }, (response) {
      if (response['status'] == 'success') {
        emit(RoomCancelSuccessState());
        upcomingBookings
            .removeWhere((bookedRoom) => bookedRoom.id == event.bookId);
      } else {
        emit(RoomCancelFailedState(message: 'Failed to cancel the room'));
      }
    });
    emit(BookedRoomFetchedState(
        bookedrooms: bookedRooms, upcomingBookings: upcomingBookings));
  }
}
