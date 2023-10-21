import 'package:east_stay/utils/constents/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.icon,
    required this.hint,
    this.isReadOnly = false,
    this.padding=20
  });
  final IconData? icon;
  final String hint;
  final bool isReadOnly;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding:  EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        readOnly: isReadOnly,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.grey,
          ),
          isDense: true,
          suffixIcon: icon == null
              ? null
              :  Icon(
                icon,
                  size: 25,
                  color: AppColor.primaryColor,
                ),
        ),
        onTap: () {},
      ),
    );
  }
}
