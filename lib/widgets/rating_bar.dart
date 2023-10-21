import 'package:east_stay/utils/constents/colors.dart';
import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  const Ratings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: _buildStar(3.1));
  }

  List<Widget> _buildStar(num ratings) {
    List<Widget> stars = [];
    for (var i = 1; i <= 5; i++) {
      if (i <= ratings) {
        stars.add(const Icon(Icons.star, color: AppColor.gold, size: 14));
      } else if (ratings >= (i - .5)) {
        stars.add(
            const Icon(Icons.star_half, color: AppColor.gold, size: 14));
      } else {
        stars.add(
            const Icon(Icons.star_border, color: AppColor.gold, size: 14));
      }
    }
    return stars;
  }
}
