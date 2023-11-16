import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';

class Amenities extends StatelessWidget {
  Amenities({
    super.key,
    required this.amenities,
  });
  final List<String> amenities;
  final amenitieIcons = {
    'TV': Icons.tv,
    'Wifi': Icons.wifi,
    'AC': Icons.ac_unit_rounded,
    'Kitchen': Icons.soup_kitchen_outlined,
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Wrap(
        spacing: 8,
        alignment: WrapAlignment.spaceEvenly,
        children: amenities
            .map(
              (e) => Chip(
                backgroundColor: Colors.white,
                label: Text(e, style: AppText.smallDark),
                avatar: Icon(
                  amenitieIcons[e],
                  size: 20,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
