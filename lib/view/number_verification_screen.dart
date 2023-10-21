import 'package:east_stay/utils/constents/colors.dart';
import 'package:east_stay/utils/constents/text_style.dart';
import 'package:east_stay/widgets/button.dart';
import 'package:flutter/material.dart';

class ScreenNumberVerification extends StatelessWidget {
  const ScreenNumberVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.sizeOf(context).height;
    final dwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SizedBox(
        height: dheight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: dheight * .25,
              width: double.maxFinite,
              color: AppColor.primaryColor,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: SizedBox()),
                  Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter you’r phone number for \nverification',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                     Text(
                      'mobile number',
                      style:
                          AppText.smallDark,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 52,
                      width: dwidth * .7,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Text('   +91 ', style: AppText.largeDark),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your mobile number',
                                hintStyle: TextStyle(
                                  color: AppColor.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox(),),
                    const PrimaryButton(label: 'Coninue',),
                    // const SizedBox(height: 20)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
