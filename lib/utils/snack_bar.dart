import 'package:another_flushbar/flushbar.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';

class MessageViewer {
  static showSnackBar(BuildContext context, String message,
      [bool isEroor = false]) {
    isEroor
        ? Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(6),
            backgroundColor: Colors.white,
            titleText: const Text(
              "EastStay",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: AppColor.primaryColor,
              ),
            ),
            messageText: Text(message, style: AppText.mediumdark),
            icon: const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 30,
            ),
          ).show(context)
        : Flushbar(
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(6),
            backgroundColor: Colors.white,
            titleText: const Text(
              "EastStay",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: AppColor.primaryColor,
              ),
            ),
            messageText: Text(
              message,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: AppColor.textSecondary,
              ),
            ),
            icon: const Icon(
              Icons.done,
              color: Colors.green,
              size: 30,
            ),
          ).show(context);
  }
}
