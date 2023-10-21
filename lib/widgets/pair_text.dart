import 'package:east_stay/utils/constents/colors.dart';
import 'package:flutter/material.dart';

class PairText extends StatelessWidget {
  const PairText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.firstColor,
    this.secondColor,
    this.isCash = false,
    this.onTap,
  });
  final String firstText;
  final String secondText;
  final Color? firstColor;
  final Color? secondColor;
  final bool isCash;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: firstText,
              style: TextStyle(
                fontSize: 12,
                color: firstColor ?? AppColor.grey,
              ),
            ),
            TextSpan(
              text: secondText,
              style: TextStyle(
                  fontSize: 12,
                  color: secondColor ?? AppColor.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: isCash ? 'Ubuntu' : 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }
}
