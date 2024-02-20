import 'package:flutter/material.dart';

class AppColor {
  static const primaryColor = Color(0xffE55959);
  static const secondaryColor = Color(0xff232323);
  static const backgroundColor = Color(0xffF4F4F4);
  static const textPrimary = Color(0xff484848);
  static const textSecondary = Color(0xff747474);
  static const gold = Color(0xffFFD700);
  static const grey = Colors.grey;
  static Color color(String name) {
    name = name.toLowerCase().trim();
    switch (name) {
      case 'classic':
        return Colors.blue[900]!;
      case 'elite':
        return const Color(0xff0B6623);
      case 'deluxe':
        return const Color(0xff35424A);
      case 'luxury':
        return gold;
      default:
        return primaryColor;
    }
  }
}
