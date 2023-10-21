// ignore_for_file: must_be_immutable

import 'package:east_stay/utils/constents/colors.dart';
import 'package:east_stay/utils/constents/text_style.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({super.key});
  final List data = ['GPay', 'Paytm', 'Card', 'Cash on CheckIn'];
  final List<String?> images = [
    'assets/images/gpay_logo.png',
    'assets/images/Paytm_Logo.png',
    null,
    null,
  ];
  String selectedRadio = '';
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) => Row(
          children: [
            Radio(
              value: data[index],
              groupValue: selectedRadio,
              onChanged: (v) {
                setstate(() {
                  selectedRadio = v;
                });
              },
              activeColor: AppColor.primaryColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(data[index], style: AppText.mediumdark),
            ),
            images[index] == null
                ? const SizedBox()
                : Image.asset(
                    images[index]!,
                    scale: 25,
                  ),
          ],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      );
    });
  }
}
