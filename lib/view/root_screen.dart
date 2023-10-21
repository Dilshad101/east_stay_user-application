import 'package:east_stay/view/booking_history_screen.dart';
import 'package:east_stay/view/favorite_screen.dart';
import 'package:east_stay/view/home_screen.dart';
import 'package:east_stay/view/settings_screen.dart';
import 'package:east_stay/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ScreenRoot extends StatelessWidget {
  ScreenRoot({super.key});

  final List screeen = const [
    ScreenHome(),
    ScreenBookingHistory(),
    ScreenFavorite(),
    ScreenSettings()
  ];
  final pageNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (context, value, child) => screeen[value],
      ),
      bottomNavigationBar: BottomNavigation(pageNotifier: pageNotifier),
    );
  }
}
