import 'package:east_stay/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:east_stay/resources/components/subtitle.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Coupons extends StatelessWidget {
  const Coupons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    print(context.read<CouponBloc>());
    // return BlocBuilder< CouponBloc,CouponState >(
    //   bloc: context.read<CouponBloc>(),
    //   builder: (context, state) {
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
                        const Text(
                          'Hotel Paragon',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Flat ₹400 off on your first booking',
                          style: AppText.small,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Text('Coupon code : ', style: AppText.small),
                            const Text(
                              'STAYFIRST',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textPrimary,
                                letterSpacing: 1,
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
                  )
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: 2,
          ),
        ),
      ],
    );
    //   },
    // );
  }
}
