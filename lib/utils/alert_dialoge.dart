
  import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';

alertPopup({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onCancel,
    required VoidCallback onOkey,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: AppText.xLarge),
        content: Text(
          content,
          style: AppText.mediumLight
              .copyWith(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        contentPadding: const EdgeInsets.all(20),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
        actions: [
          TextButton(
              onPressed: onCancel,
              child: Text('Cancel',
                  style: AppText.smallDark.copyWith(color: Colors.blue))),
          TextButton(
              onPressed: onOkey,
              child: Text('Signout',
                  style: AppText.smallDark.copyWith(color: Colors.red))),
        ],
      ),
    );
  }