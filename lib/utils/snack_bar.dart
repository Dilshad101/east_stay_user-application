import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:east_stay/resources/constants/text_style.dart';
// import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';

class MessageViewer {
  static showSnackBar(BuildContext context, String message,
      [bool isEroor = false]) {
    isEroor
        ? CherryToast.error(
                title: const Text(""),
                displayTitle: false,
                description: Text(message, style: AppText.mediumdark),
                animationType: AnimationType.fromRight,
                animationDuration: const Duration(milliseconds: 1000),
                autoDismiss: true)
            .show(context)
        : CherryToast.info(
            title: Text('EastStay',
                style: AppText.largeDark.copyWith(color: Colors.green)),
            action: Text(message, style: AppText.mediumdark),
            animationType: AnimationType.fromTop,
            displayCloseButton: false,
            displayIcon: false,
            autoDismiss: true,
          ).show(context);
  }
}
