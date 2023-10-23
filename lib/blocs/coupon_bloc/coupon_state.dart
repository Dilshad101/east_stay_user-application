part of 'coupon_bloc.dart';

abstract class CouponState {}

final class CouponInitial extends CouponState {}

final class CouponLoadedSuccessfullState extends CouponState {
  final List<Coupon> couponList;

  CouponLoadedSuccessfullState({required this.couponList});
}
