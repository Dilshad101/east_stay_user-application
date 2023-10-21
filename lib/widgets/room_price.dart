import 'package:flutter/material.dart';

class Price extends StatelessWidget {
  const Price({
    super.key,
    required this.price,
    this.color,
    this.size,
    this.textSize,
  });
  final String price;
  final Color? color;
  final double? size;
  final double? textSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          textSize == null ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Text(
          ' ₹ $price',
          style: TextStyle(
            fontSize: size == null ? 14 : size! + 1,
            fontWeight: FontWeight.w600,
            color: color ?? Colors.white,
            fontFamily: 'Ubuntu',
          ),
        ),
        Text(
          ' per Night',
          style: TextStyle(
            fontSize: textSize ?? size ?? 13,
            color: color ?? Colors.white,
          ),
        ),
      ],
    );
  }
}
