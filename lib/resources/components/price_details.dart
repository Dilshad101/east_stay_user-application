import 'package:east_stay/blocs/bookin_bloc/booking_bloc.dart';
import 'package:east_stay/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:east_stay/models/room_model.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_text_field.dart';
import 'subtitle.dart';

class PriceDetails extends StatelessWidget {
  PriceDetails(this.hotel, {super.key});
  final Hotel hotel;
  final couponController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubTitle('Price Details', fontSize: 16, padding: 0),
          const SizedBox(height: 20),
          couponField(context, dwidth),
          const SizedBox(height: 15),
          BlocBuilder<RoomBookingBloc, BookingState>(
            builder: (context, state) {
              if (state is BookingFieldFilledState) {
                return priceDetails(
                  leading: 'x ${state.bookingData['dayCount'] ?? 1} Nights',
                  trailing:
                      '₹ ${(state.bookingData['dayCount'] ?? 1) * int.parse(hotel.price)}',
                  price: hotel.price,
                );
              }
              return priceDetails(
                  leading: 'x 1 Night',
                  trailing: hotel.price,
                  price: hotel.price);
            },
          ),
          const SizedBox(height: 15),
          priceDetails(leading: 'Guests', trailing: '1'),
          const SizedBox(height: 15),
          priceDetails(leading: 'Rooms', trailing: '1'),
          const SizedBox(height: 15),
          priceDetails(leading: 'Discount', trailing: '₹ 0'),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Row couponField(BuildContext context, double dwidth) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          hint: 'Apply Coupon code',
          controller: couponController,
          padding: 0,
        )),
        const SizedBox(width: 5),
        BlocListener<CouponBloc, CouponState>(
          listenWhen: (previous, current) => current is CouponActionState,
          listener: (context, state) {
            if (state is CouponAppliedSuccessfullState) {
              MessageViewer.showSnackBar(context, 'coupon applied');
            } else if (state is CouponAppliedFailedState) {
              MessageViewer.showSnackBar(context, state.message, true);
            }
          },
          child: InkWell(
            onTap: () {
              context
                  .read<CouponBloc>()
                  .add(ApplyCouponEvent(couponCode: couponController.text));
            },
            child: Container(
              height: 48,
              width: dwidth * .22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.black),
              child: const Text(
                'Apply',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row priceDetails({
    required String leading,
    required String trailing,
    String? price,
  }) {
    return Row(
      children: [
        price != null
            ? Text(
                "₹ $price",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textSecondary,
                  fontFamily: 'Ubuntu',
                ),
              )
            : const SizedBox.shrink(),
        Text(
          leading,
          style: const TextStyle(fontSize: 13, color: AppColor.textSecondary),
        ),
        const Spacer(),
        Text(
          trailing,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColor.textPrimary,
            fontFamily: 'Ubuntu',
          ),
        ),
      ],
    );
  }
}
