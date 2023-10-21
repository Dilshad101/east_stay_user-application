import 'package:east_stay/resources/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: AppColor.backgroundColor,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: AppColor.secondaryColor),
    backgroundColor: AppColor.backgroundColor,
    centerTitle: true,
    elevation: .5,
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: AppColor.secondaryColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: AppColor.textPrimary),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.grey[800]!),
    ),
  ),
);
