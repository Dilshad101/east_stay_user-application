part of 'booked_room_bloc.dart';

abstract class BookedRoomState {}

abstract class BookedRoomActionState extends BookedRoomState {}

final class BookedRoomInitial extends BookedRoomState {}

final class BookedRoomLoadingState extends BookedRoomState {}

final class BookedRoomFetchedState extends BookedRoomState {
  final List<BookedRoom> bookedrooms;
  final List<BookedRoom> upcomingBookings;
  BookedRoomFetchedState(
      {required this.bookedrooms, required this.upcomingBookings});
}

final class BookedRoomFetchedErrorState extends BookedRoomState {
  final String message;

  BookedRoomFetchedErrorState({required this.message});
}

final class RoomRatedSuccessState extends BookedRoomActionState {}

final class RoomRatedFailedState extends BookedRoomActionState {}

final class RoomCancelSuccessState extends BookedRoomActionState {}

final class RoomCancelFailedState extends BookedRoomActionState {
  final String message;

  RoomCancelFailedState({required this.message});
}
