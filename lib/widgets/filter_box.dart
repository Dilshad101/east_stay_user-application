import 'package:east_stay/utils/constents/colors.dart';
import 'package:east_stay/utils/constents/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key, required this.filterNotifier});

  final ValueNotifier<bool> filterNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: filterNotifier,
      builder: (context, value, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: value ? 350 : 0,
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
            child: StatefulBuilder(builder: (context, setState) {
              return SizedBox(
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category', style: AppText.largeDark),
                    const SizedBox(height: 10),
                    checkBox(value),
                    checkBox(value),
                    const SizedBox(height: 20),
                    Text('Price', style: AppText.largeDark),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('₹500',
                            style:
                                AppText.small.copyWith(fontFamily: 'Ubuntu')),
                        Expanded(child: priceSlider()),
                        Text(
                          '> ₹5000',
                          style: AppText.small.copyWith(fontFamily: 'Ubuntu'),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                          onPressed: () {
                            setState(() => filterNotifier.value = false);
                          },
                          child: const Text('Apply')),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  FlutterSlider priceSlider() {
    return FlutterSlider(
      max: 5000,
      min: 500,
      values: const [500],
      onDragCompleted: (handlerIndex, from, to) {},
      trackBar: const FlutterSliderTrackBar(
        activeTrackBar: BoxDecoration(color: AppColor.primaryColor),
      ),
      handler: FlutterSliderHandler(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: const CircleAvatar(
          radius: 10,
          backgroundColor: AppColor.primaryColor,
        ),
      ),
      handlerHeight: 30,
      handlerAnimation: const FlutterSliderHandlerAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.bounceIn,
          duration: Duration(milliseconds: 500),
          scale: 1.1),
    );
  }

  Row checkBox(bool value) {
    return Row(
      children: [
        Expanded(
            child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value) {},
            ),
            const SizedBox(width: 10),
            Text('Classic', style: AppText.mediumdark),
          ],
        )),
        Expanded(
            child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value) {},
            ),
            const SizedBox(width: 10),
            Text('Classic', style: AppText.mediumdark),
          ],
        ))
      ],
    );
  }
}
