part of 'coupon_bloc.dart';

abstract class CouponEvent {}

class FetchCouponsEvent extends CouponEvent {
  final Vendor vendor;

  FetchCouponsEvent({required this.vendor});
}

class ClearCouponsEvent extends CouponEvent {}

class ApplyCouponEvent extends CouponEvent {
  final String couponCode;

  ApplyCouponEvent({required this.couponCode});
}
