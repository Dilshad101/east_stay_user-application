import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_style.dart';

class BoxTile extends StatelessWidget {
  const BoxTile({
    super.key,
    this.price = false,
    required this.type,
    required this.title,
    required this.value,
  });
  final BoxType type;
  final bool price;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return type==BoxType.multiLine
        ? Expanded(
            child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.8),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppText.mediumLight
                      .copyWith(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: AppText.mediumLight.copyWith(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ))
        : Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.8),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppText.mediumdark),
                Text(
                  value,
                  style: price
                      ? AppText.largeDark.copyWith(
                          color: AppColor.secondaryColor, fontFamily: 'Ubuntu')
                      : AppText.smallDark.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
  }
}

enum BoxType { singleLine, multiLine }
