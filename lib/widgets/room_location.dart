import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  const Location({
    super.key,
    required this.state,
    required this.city,
    this.color, this.size,
  });
  final String state;
  final String city;
  final Color? color;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Icon(
          Icons.location_on_outlined,
          color:color?? Colors.white,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          city,
          style:  TextStyle(
            fontSize:size?? 13,
            color:color?? Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 5),
         CircleAvatar(
          radius: 2,
          backgroundColor:color?? Colors.white,
        ),
        const SizedBox(width: 5),
        Text(
          state,
          style:  TextStyle(
            fontSize:size?? 13,
            color:color?? Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
