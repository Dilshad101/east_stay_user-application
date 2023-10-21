
import 'package:east_stay/resources/constants/colors.dart';
import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  const SubTitle(this.subtitle, {super.key,this.padding, this.fontSize});
  final String subtitle;
  final double? padding;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:padding?? 20.0),
      child: Text(
        subtitle,
        style:  TextStyle(
          fontSize:fontSize?? 18,
          fontWeight: FontWeight.w600,
          color: AppColor.secondaryColor,
        ),
      ),
    );
  }
}
