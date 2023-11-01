part of 'booked_room_bloc.dart';

abstract class BookedRoomEvent {}

class FetchBookedRoomsEvent extends BookedRoomEvent {}

class RateBookedRoomsEvent extends BookedRoomEvent {
  final String roomId;
  final String feedback;
  final String stars;
  final String vendorId;

  RateBookedRoomsEvent({
    required this.roomId,
    required this.feedback,
    required this.stars,
    required this.vendorId,
  });
}

class CancelBookedRoomsEvent extends BookedRoomEvent {
  final String bookId;

  CancelBookedRoomsEvent({required this.bookId});
}
// roomId, feedback, stars, vendorId -(body)   pass token usertoken