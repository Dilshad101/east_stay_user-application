// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:east_stay/blocs/search_bloc/search_bloc.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class FilterBox extends StatelessWidget {
  FilterBox({
    super.key,
    required this.boxNotifier,
    required this.filterNotifier,
    required this.priceNotifier,
  });

  final ValueNotifier<bool> boxNotifier;
  final ValueNotifier<Map<String, bool>> filterNotifier;
  final ValueNotifier<double?> priceNotifier;
  final catagoryList = ['Classic', 'Elite', 'Deluxe', 'Luxury'];
  final List<String> selectedCategories = [];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boxNotifier,
      builder: (context, value, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: value ? 370 : 0,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
            border: Border.all(
              width: .5,
              color: AppColor.textSecondary.withOpacity(.4),
            ),
          ),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category', style: AppText.largeDark),
                  const SizedBox(height: 10),
                  ValueListenableBuilder(
                    valueListenable: filterNotifier,
                    builder: (context, value, child) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1 / .4,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            value: value[catagoryList[index]],
                            title: Text(catagoryList[index]),
                            onChanged: (selected) {
                              filterNotifier.value[catagoryList[index]] =
                                  selected ?? false;
                              filterNotifier.notifyListeners();
                            },
                            activeColor: AppColor.primaryColor,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text('Price', style: AppText.largeDark),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('₹500',
                          style: AppText.smallDark.copyWith(fontFamily: 'Ubuntu')),
                      Expanded(child: priceSlider()),
                      Text(
                        '> ₹5000',
                        style: AppText.smallDark.copyWith(fontFamily: 'Ubuntu'),
                      ),
                    ],
                  ),
                  const Divider(
                    // height: 20,
                    thickness: 1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          selectedCategories.clear();
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
                          boxNotifier.value = false;
                        },
                        child: Text(
                          'Apply',
                          style: AppText.mediumdark,
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget priceSlider() {
    return ValueListenableBuilder(
      valueListenable: priceNotifier,
      builder: (context, value, _) {
        return FlutterSlider(
          max: 5000,
          min: 500,
          values: [value ?? 500],
          onDragCompleted: (handlerIndex, end, start) {
            priceNotifier.value = end;
          },
          trackBar: const FlutterSliderTrackBar(
            activeTrackBar: BoxDecoration(color: AppColor.primaryColor),
          ),
          handler: FlutterSliderHandler(
            decoration: const BoxDecoration(color: Colors.transparent),
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
        );
      },
    );
  }
}
