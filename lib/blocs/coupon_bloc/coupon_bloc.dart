import 'package:east_stay/models/coupon_model.dart';
import 'package:east_stay/models/vendor_model.dart';
import 'package:east_stay/repositories/room_booking_repo.dart';
import 'package:east_stay/repositories/room_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitial()) {
    on<FetchCouponsEvent>(_fetchCouponsEvent);
    on<ClearCouponsEvent>(_clearCouponEvent);
    on<ApplyCouponEvent>(_applyCouponCode);
  }
  List<Coupon> _couponList = [];

  _fetchCouponsEvent(FetchCouponsEvent event, Emitter<CouponState> emit) async {
    final either = await RoomRepo().getRoomCoupon(event.vendor.id);

    either.fold((error) {
      emit(CouponEmptyState());
    }, (response) {
      final rawList = response['coupon'] as List;

      if (rawList.isEmpty) return emit(CouponEmptyState());

      _couponList = rawList
          .map((e) => Coupon.fromJson(e, event.vendor.propertyName))
          .toList();
      _couponList = _couponList
          .where((coupon) => coupon.endDate.isAfter(DateTime.now()))
          .toList();
      emit(CouponLoadedSuccessfullState(couponList: _couponList));
    });
  }

  _clearCouponEvent(ClearCouponsEvent event, Emitter<CouponState> emit) {
    emit(CouponEmptyState());
  }

  _applyCouponCode(ApplyCouponEvent event, Emitter<CouponState> emit) async {
    final selectedCoupons = _couponList
        .where((element) => element.couponCode == event.couponCode)
        .toList();
    if (selectedCoupons.isEmpty) {
      emit(CouponAppliedFailedState(message: 'coupon does not exist'));
      return;
    }
    final vendorId = selectedCoupons.first.vendorId;
    final couponCode = selectedCoupons.first.couponCode;
    final coupon = {'couponCode': couponCode, 'vendorid': vendorId};

    final either = await RoomBookingRepo().applyCoupon(coupon);
    either.fold((error) {
      emit(CouponAppliedFailedState(message: error.message));
    }, (response) {
      if (response['status'] == 'success') {
        emit(CouponAppliedSuccessfullState());
      } else {
        emit(CouponAppliedFailedState(message: response['message']));
      }
    });
  }
}
