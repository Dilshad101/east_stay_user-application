part of 'booking_bloc.dart';

abstract class BookingEvent {}

final class SelectBookingDatesEvent extends BookingEvent {
  final int numberOfDays;
  final String checkin;
  final String checkout;

  SelectBookingDatesEvent({
    required this.checkin,
    required this.checkout,
    required this.numberOfDays,
  });
}

final class ApplyDiscountEvent extends BookingEvent {
  final String discount;

  ApplyDiscountEvent({required this.discount});
}

final class UpdateGuestEvent extends BookingEvent {
  final String count;

  UpdateGuestEvent({required this.count});
}

final class UpdateRoomEvent extends BookingEvent {
  final String count;

  UpdateRoomEvent({required this.count});
}

final class ResetBookingEvent extends BookingEvent {}

final class RoomEnquiryEvent extends BookingEvent {
  final String mobileNumber;
  final String address;
  final Hotel hotel;
  final String roomId;

  RoomEnquiryEvent(
      {required this.roomId,
      required this.address,
      required this.hotel,
      required,
      required this.mobileNumber});
}

final class SetRoomEvent extends BookingEvent {
  final String mobileNumber;
  final String address;

  Hotel hotel;

  SetRoomEvent(
      {required this.mobileNumber, required this.address, required this.hotel});
}

final class BookRoomEvent extends BookingEvent {}

final class PaymentFailedEvent extends BookingEvent {}
