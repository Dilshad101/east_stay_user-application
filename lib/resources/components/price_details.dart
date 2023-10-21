
import 'package:east_stay/resources/constants/colors.dart';
import 'package:flutter/material.dart';

import 'custom_text_field.dart';
import 'subtitle.dart';

class PriceDetails extends StatelessWidget {
  const PriceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubTitle('Price Details', fontSize: 16,padding: 0,),
          const SizedBox(height: 20),
          Row(
            children: [
              const Expanded(
                  child: CustomTextField(
                hint: 'Apply Coupon code',
                padding: 0,
              )),
              const SizedBox(width: 5),
              Container(
                height: 48,
                width: dwidth * .22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.black),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          priceDetails(leading: 'x 2 Nights', trailing: '₹2000', isPrice: true),
          const SizedBox(height: 15),
          priceDetails(leading: 'Discount', trailing: '₹0', isPrice: false),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Row priceDetails(
      {required String leading,
      required String trailing,
      required bool isPrice}) {
    return Row(
      children: [
        isPrice
            ? Text(
                trailing,
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
