// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:east_stay/utils/constents/colors.dart';
import 'package:east_stay/utils/constents/text_style.dart';
import 'package:east_stay/widgets/floating_tabbar.dart';
import 'package:east_stay/widgets/room_tile.dart';
import 'package:east_stay/widgets/search_bar.dart';
import 'package:east_stay/widgets/home_top_rooms.dart';
import 'package:east_stay/widgets/title_text.dart';
import 'package:flutter/material.dart';

import 'search_screen.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    // final dwidth = MediaQuery.sizeOf(context).width;
    // final dheight = MediaQuery.sizeOf(context).height;
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
              SliverPersistentHeader(
                delegate: FloatingTabBar(
                  TabBar(
                    indicator: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    indicatorPadding: EdgeInsets.symmetric(vertical: 2),
                    labelColor: Colors.white,
                    labelStyle: AppText.mediumdark.copyWith(letterSpacing: .5),
                    unselectedLabelColor: AppColor.textSecondary,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    tabs: [
                      Tab(text: 'Classic'),
                      Tab(text: 'Elite'),
                      Tab(text: 'Deluxe'),
                      Tab(text: 'Luxury'),
                    ],
                  ),
                ),
                floating: true,
                pinned: true,
              )
            ],
            body: TabBarView(
              children: [
                GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1 / 1.2),
                    itemCount: 9,
                    itemBuilder: (context, index) => RoomTile()),
                Column(
                  children: [
                    Container(color: Colors.red, height: 100),
                  ],
                ),
                Container(color: Colors.green),
                Container(color: Colors.yellow),
              ],
            ),
          ),
        ),
      ),
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
