import 'package:east_stay/resources/components/room_catagory.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/components/floating_tabbar.dart';
import 'package:east_stay/resources/components/search_bar.dart';
import 'package:east_stay/resources/components/home_top_rooms.dart';
import 'package:east_stay/resources/components/title_text.dart';
import 'package:flutter/material.dart';

import 'search_screen.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                collapsedHeight: 420,
                expandedHeight: 420,
                flexibleSpace: _header(context),
              ),
              _tabBar()
            ],
            body: _tabBarView(),
          ),
        ),
      ),
    );
  }

  TabBarView _tabBarView() {
    return const TabBarView(
      children: [
        RoomCatagory(catagory: 'Classic'),
        RoomCatagory(catagory: 'Elite'),
        RoomCatagory(catagory: 'Deluxe'),
        RoomCatagory(catagory: 'Luxury'),
      ],
    );
  }

  SliverPersistentHeader _tabBar() {
    return SliverPersistentHeader(
      delegate: FloatingTabBar(
        TabBar(
          indicator: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(100),
          ),
          indicatorPadding: const EdgeInsets.symmetric(vertical: 2),
          labelColor: Colors.white,
          labelStyle: AppText.mediumdark.copyWith(letterSpacing: .5),
          unselectedLabelColor: AppColor.textSecondary,
          padding: const EdgeInsets.symmetric(vertical: 8),
          tabs: const [
            Tab(text: 'Classic'),
            Tab(text: 'Elite'),
            Tab(text: 'Deluxe'),
            Tab(text: 'Luxury'),
          ],
        ),
      ),
      floating: true,
      pinned: true,
    );
  }

  Column _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        AppSearchBar(
          onFilterPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ScreenSearch()),
          ),
        ),
        const SizedBox(height: 30),
        const TitleText('Top Rooms only for you'),
        const SizedBox(height: 20),
        const HomeTopRooms(),
        const SizedBox(height: 30),
        const TitleText('Browse Categories'),
      ],
    );
  }
}
