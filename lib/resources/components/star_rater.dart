// ignore_for_file: must_be_immutable

import 'package:east_stay/resources/constants/colors.dart';
import 'package:flutter/material.dart';

class StarRater extends StatelessWidget {
  StarRater({super.key, required this.onChanged, required this.rate});
  final Function(int) onChanged;
  int rate;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      child: StatefulBuilder(
        builder: (context, setstate) {
          return Align(
            alignment: Alignment.center,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setstate(() {
                    if (rate == index) {
                      rate--;
                      onChanged(rate + 1);
                      return;
                    }
                    rate = index;
                  });
                  onChanged(rate + 1);
                },
                child: Icon(
                  Icons.star,
                  color: index <= rate ? AppColor.gold : AppColor.grey,
                  size: 30,
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
            ),
          );
        },
      ),
    );
  }
}
