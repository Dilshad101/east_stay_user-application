part of 'booking_bloc.dart';

abstract class BookingEvent {}

class SelectBookingDatesEvent extends BookingEvent {
  final int numberOfDays;
  final String checkin;
  final String checkout;

  SelectBookingDatesEvent({
    required this.checkin,
    required this.checkout,
    required this.numberOfDays,
  });
}
