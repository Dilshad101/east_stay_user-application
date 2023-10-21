
import 'package:east_stay/resources/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.pageNotifier,
  });

  final ValueNotifier<int> pageNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (context, value, _) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(BoxIcons.bx_home_alt_2),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(BoxIcons.bx_collection),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(BoxIcons.bx_heart),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(BoxIcons.bx_user),
                label: 'Profile',
              ),
            ],
            currentIndex: pageNotifier.value,
            onTap: (index) => pageNotifier.value = index,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            fixedColor: Colors.blue,
            selectedIconTheme:
                const IconThemeData(color: AppColor.primaryColor, size: 25),
            unselectedIconTheme:
                const IconThemeData(color: AppColor.grey, size: 22),
          );
        });
  }
}
