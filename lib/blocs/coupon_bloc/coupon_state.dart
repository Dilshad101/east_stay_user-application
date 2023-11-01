part of 'coupon_bloc.dart';

abstract class CouponState {}

abstract class CouponActionState extends CouponState {}

final class CouponInitial extends CouponState {}

final class CouponLoadedSuccessfullState extends CouponState {
  final List<Coupon> couponList;

  CouponLoadedSuccessfullState({required this.couponList});
}

final class CouponEmptyState extends CouponState {}

final class CouponAppliedSuccessfullState extends CouponActionState {}

final class CouponAppliedFailedState extends CouponActionState {
  final String message;

  CouponAppliedFailedState({required this.message});
}
