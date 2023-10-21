
import 'package:east_stay/utils/constents/colors.dart';
import 'package:east_stay/utils/constents/text_style.dart';
import 'package:flutter/material.dart';

class BookingDetail extends StatelessWidget {
  const BookingDetail({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Icon(icon,color: AppColor.primaryColor,),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: AppText.mediumdark
            ),
          ),
          getOperationContainer(
            child: Icon(
              Icons.remove,
              size: 20,
              color: AppColor.grey[700],
            ),
          ),
          const SizedBox(width: 10),
          getOperationContainer(child: const Text('1')),
          const SizedBox(width: 10),
          getOperationContainer(
            child: Icon(
              Icons.add,
              size: 20,
              color: AppColor.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Container getOperationContainer({required Widget child}) {
    return Container(
        height: 25,
        width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.grey),
        ),
        child: child);
  }
}
