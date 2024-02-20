part of 'booking_bloc.dart';

abstract class BookingState {}

abstract class BookingActionState extends BookingState {}

// class PaymentSuccesState extends BookingActionState {}

final class BookingInitial extends BookingState {}

final class RoomBookedSuccessState extends BookingState {}

final class RoomBookingFailedState extends BookingState {}

final class BookingFieldFilledState extends BookingActionState {
  final Map<String, dynamic> bookingData;

  BookingFieldFilledState({required this.bookingData});
}

// final class BookingDateAvailableState extends BookingState {}

final class BookingDateNotAvailableState extends BookingState {}

final class BookingLoadingState extends BookingState {}

final class BookingFailedState extends BookingState {
  final String message;

  BookingFailedState({required this.message});
}

final class RoomAvailableState extends BookingState {
  final Map<String, dynamic> bookingData;

  RoomAvailableState({required this.bookingData});
}
