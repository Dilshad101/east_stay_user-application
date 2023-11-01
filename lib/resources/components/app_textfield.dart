import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    this.controller,
    this.icon,
    this.suffixIcon,
    this.hint,
    this.borderRadius,
    this.isReadOnly = false,
    this.onTap,
    this.fillColor,
    this.validator,
    this.isObscured = false,
    this.keyboard = TextInputType.name,
    this.onChanged,
    this.autoValidate = true,
  });
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final double? borderRadius;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final Color? fillColor;
  final FormFieldValidator? validator;
  final bool isObscured;
  final TextInputType keyboard;
  final void Function(String)? onChanged;
  final bool autoValidate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        readOnly: isReadOnly,
        autovalidateMode:
            autoValidate ? AutovalidateMode.onUserInteraction : null,
        onTap: onTap,
        validator: validator,
        obscureText: isObscured,
        keyboardType: keyboard,
        onChanged: onChanged,
        style: AppText.mediumdark.copyWith(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          hintText: hint,
          fillColor: fillColor,
          filled: fillColor == null ? false : true,
          constraints: const BoxConstraints(minHeight: 35, maxHeight: 70),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          labelStyle: const TextStyle(color: AppColor.grey),
          hintStyle: AppText.mediumdark.copyWith(
            color: AppColor.grey[600],
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            borderSide: BorderSide(
              color: AppColor.grey[400]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            borderSide: BorderSide(
              color: AppColor.grey[500]!,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            borderSide: BorderSide(
              color: Colors.red[500]!,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            borderSide: BorderSide(
              color: Colors.red[500]!,
              width: 1.5,
            ),
          ),
          prefixIcon: icon == null
              ? null
              : Icon(
                  icon,
                  size: 26,
                  color: AppColor.grey,
                ),
          suffixIcon: suffixIcon == null
              ? null
              : Icon(
                  suffixIcon,
                  size: 22,
                  color: AppColor.secondaryColor,
                ),
        ),
      ),
    );
  }
}
