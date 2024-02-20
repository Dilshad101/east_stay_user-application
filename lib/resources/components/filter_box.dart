// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:east_stay/blocs/search_bloc/search_bloc.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({
    super.key,
    required this.filterNotifier,
    required this.priceNotifier,
  });

  final ValueNotifier<Map<String, bool>> filterNotifier;
  final ValueNotifier<double?> priceNotifier;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: AppText.xLarge.copyWith(color: Colors.grey),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close,
                  color: AppColor.grey[700],
                  size: 24,
                ),
                padding: const EdgeInsets.all(0),
              )
            ],
          ),
          const SizedBox(height: 10),
          priceSliderr(),
          const SizedBox(height: 10),
          Text('Category', style: AppText.mediumdark),
          ValueListenableBuilder(
            valueListenable: filterNotifier,
            builder: (context, value, child) {
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = filterNotifier.value.keys.toList()[index];
                  return SizedBox(
                    height: 38,
                    child: CheckboxListTile(
                      value: value[category],
                      activeColor: AppColor.primaryColor,
                      title: Text(category, style: AppText.smallDark),
                      onChanged: (selected) {
                        value[category] = selected ?? false;
                        filterNotifier.notifyListeners();
                      },
                    ),
                  );
                },
                itemCount: 4,
              );
            },
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          SizedBox(
            width: double.maxFinite,
            height: 48,
            child: TextButton(
                onPressed: () {
                  final selectedCategories = <String>[];
                  filterNotifier.value.forEach((key, value) {
                    if (value) {
                      selectedCategories.add(key);
                    }
                  });
                  context.read<SearchBloc>().add(
                        SearchHotelEvent(
                          query: '',
                          filterList: selectedCategories,
                          priceRange: priceNotifier.value,
                        ),
                      );
                  Navigator.pop(context);
                },
                child: Text(
                  'Apply',
                  style: AppText.mediumdark,
                )),
          ),
        ],
      ),
    );
  }

  Widget priceSliderr() {
    return ValueListenableBuilder(
      valueListenable: priceNotifier,
      builder: (context, val, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price', style: AppText.mediumdark),
                priceNotifier.value != null
                    ? Text(
                        '${priceNotifier.value}',
                        style: AppText.mediumdark,
                      )
                    : const SizedBox()
              ],
            ),
            Row(
              children: [
                Text('₹500',
                    style: AppText.smallDark.copyWith(fontFamily: 'Ubuntu')),
                Expanded(
                  child: FlutterSlider(
                    max: 5000,
                    min: 500,
                    values: [val ?? 500],
                    onDragCompleted: (handlerIndex, end, start) {
                      priceNotifier.value = end;
                    },
                    trackBar: const FlutterSliderTrackBar(
                      activeTrackBar:
                          BoxDecoration(color: AppColor.primaryColor),
                    ),
                    handler: FlutterSliderHandler(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: const CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColor.primaryColor,
                      ),
                    ),
                    handlerHeight: 30,
                    handlerAnimation: const FlutterSliderHandlerAnimation(
                      curve: Curves.elasticOut,
                      reverseCurve: Curves.bounceIn,
                      duration: Duration(milliseconds: 500),
                      scale: 1.1,
                    ),
                  ),
                ),
                Text(
                  '> ₹5000',
                  style: AppText.smallDark.copyWith(fontFamily: 'Ubuntu'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
