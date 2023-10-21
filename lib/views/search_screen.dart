

import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/components/filter_box.dart';
import 'package:east_stay/resources/components/search_bar.dart';
import 'package:east_stay/resources/components/search_room_tile.dart';
import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});
  final filterNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    // final dwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover your room'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) => const SearchTile(),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
          ),
          Positioned(
            top: 70,
            left: 20,
            right: 20,
            child: FilterBox(filterNotifier: filterNotifier),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: Column(
              children: [
                AppSearchBar(
                  ishome: false,
                  onFilterPressed: () =>
                      filterNotifier.value = !filterNotifier.value,
                ),
                Container(height: 20, color: AppColor.backgroundColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
