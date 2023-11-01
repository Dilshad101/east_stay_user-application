part of 'booking_bloc.dart';

abstract class BookingState {}

abstract class BookingActionState extends BookingState {}

final class BookingInitial extends BookingState {}

final class BookingFieldFilledState extends BookingState {
  final Map<String,dynamic> bookingData;

  BookingFieldFilledState({required this.bookingData});
}
