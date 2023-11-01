import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:flutter/material.dart';

class BookingCount extends StatelessWidget {
  const BookingCount({
    super.key,
    this.isGuest = true,
    required this.icon,
    required this.label,
    required this.numberNotifier,
    required this.limit,
  });
  final IconData icon;
  final String label;
  final ValueNotifier<int> numberNotifier;
  final int limit;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Icon(icon, color: AppColor.textSecondary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: AppText.mediumdark),
          ),
          getOperationContainer(
            child: Icon(
              Icons.remove,
              size: 20,
              color: AppColor.grey[700],
            ),
            onTap: () {
              if (numberNotifier.value <= 1) return;
              numberNotifier.value--;
            },
          ),
          const SizedBox(width: 10),
          numberBuilder(),
          const SizedBox(width: 10),
          getOperationContainer(
            child: Icon(
              Icons.add,
              size: 20,
              color: AppColor.grey[700],
            ),
            onTap: () {
              final message = isGuest
                  ? 'Maximum Room Occupancy Achieved'
                  : 'only $limit Rooms Available';

              if (numberNotifier.value >= limit) {
                MessageViewer.showSnackBar(
                  context,
                  message,
                  true,
                );
                return;
              }
              numberNotifier.value++;
            },
          ),
        ],
      ),
    );
  }

  Widget numberBuilder() {
    return ValueListenableBuilder(
      valueListenable: numberNotifier,
      builder: (context, value, child) {
        return Container(
            height: 25,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColor.grey),
            ),
            child: Text('${numberNotifier.value}'));
      },
    );
  }

  Widget getOperationContainer(
      {required Widget child, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 25,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColor.grey),
          ),
          child: child),
    );
  }
}
