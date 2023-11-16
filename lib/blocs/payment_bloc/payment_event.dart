part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class OpenPaymentEvent extends PaymentEvent {
  final String mobileNumber;
  final String propertyName;
  final int total;

  OpenPaymentEvent(
      {required this.mobileNumber,
      required this.propertyName,
      required this.total});
}

class PaymentSuccessEvent extends PaymentEvent {}

class PaymentFailedEvent extends PaymentEvent {}
