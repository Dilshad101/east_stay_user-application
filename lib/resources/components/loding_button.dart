import 'package:east_stay/resources/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/text_style.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    this.margin,
    this.onTap,
    this.label,
    this.isLoading = false,
  });
  final double? margin;
  final VoidCallback? onTap;
  final String? label;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        margin:
            margin == null ? null : EdgeInsets.symmetric(horizontal: margin!),
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColor.primaryColor),
        child: isLoading
            ? Transform.scale(
                scale: .7,
                child: const CircularProgressIndicator(color: Colors.white),
              )
            : Text('Login', style: AppText.mediumLight),
      ),
    );
  }
}
