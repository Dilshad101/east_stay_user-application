
import 'package:east_stay/resources/constants/colors.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColor.secondaryColor,
        ),
      ),
    );
  }
}
