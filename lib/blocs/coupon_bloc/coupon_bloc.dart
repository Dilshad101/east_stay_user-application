import 'dart:async';

import 'package:east_stay/models/coupons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitial()) {
    on<FetchCouponsEvent>(fetchCouponsEvent);
  }

  FutureOr<void> fetchCouponsEvent(
      FetchCouponsEvent event, Emitter<CouponState> emit) {}
}
