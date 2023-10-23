import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/views/booking_history_screen.dart';
import 'package:east_stay/views/favorite_screen.dart';
import 'package:east_stay/views/home_screen.dart';
import 'package:east_stay/views/settings_screen.dart';
import 'package:east_stay/resources/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            context.read<HomeBloc>().add(HomeGetAllHotelsEvent());
          }),
    );
  }
}
