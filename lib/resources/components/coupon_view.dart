import 'package:east_stay/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:east_stay/models/coupon_model.dart';
import 'package:east_stay/models/vendor_model.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Coupons extends StatelessWidget {
  const Coupons({
    super.key,
    required this.vendor,
  });
  final Vendor vendor;
  @override
  Widget build(BuildContext context) {
    final couponBloc = context.read<CouponBloc>();
    final dwidth = MediaQuery.sizeOf(context).width;
    couponBloc.add(FetchCouponsEvent(vendor: vendor));

    return BlocBuilder<CouponBloc, CouponState>(
      bloc: couponBloc,
      buildWhen: (previous, current) => current is! CouponActionState,
      builder: (context, state) {
        if (state is CouponLoadedSuccessfullState) {
          return couponList(dwidth, state.couponList);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Column couponList(double dwidth, List<Coupon> coupons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SubTitle('Coupons'),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              height: 100,
              width: dwidth * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: .5, color: const Color(0xff747474)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: dwidth * .58,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coupons[index].hotelName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Flat ₹${coupons[index].discount} off on this coupon',
                          style: AppText.smallDark.copyWith(
                              fontFamily: 'Ubuntu', letterSpacing: .6),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                        Row(
                          children: [
                            Text('Coupon code : ', style: AppText.smallDark),
                            Text(
                              coupons[index].couponCode,
                              style: AppText.smallDark.copyWith(
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'T&C Apply',
                            style: TextStyle(
                              fontSize: 8,
                              color: AppColor.textPrimary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: coupons[index].couponCode,
                          ),
                        );

                        // code to remove
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.grey[200],
                            content: Text(
                              'Coupon code is copied to clipboard',
                              style: AppText.smallDark,
                            )));
                      },
                      child: Container(
                        height: 100,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                          color: Colors.blue,
                        ),
                        child: const Text(
                          'Copy code',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: coupons.length,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
