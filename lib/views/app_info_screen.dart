
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/strings/app_info_strings.dart';
import 'package:flutter/material.dart';

class ScreenAppInfo extends StatelessWidget {
  const ScreenAppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('About East Stay',
              style:
                  AppText.xLarge.copyWith(fontSize: 20, color: Colors.black)),
          const SizedBox(height: 10),
          Text(AppInfo.about, style: AppText.smallDark.copyWith(fontSize: 13)),
          const SizedBox(height: 20),
          Text('Our Mission:', style: AppText.largeDark),
          const SizedBox(height: 8),
          Text(AppInfo.ourMission, style: AppText.smallDark),
          const SizedBox(height: 20),
          Text('Key Features:', style: AppText.largeDark),
          const SizedBox(height: 8),
          features('Search and Book:', AppInfo.searchAndBook),
          const SizedBox(height: 8),
          features('User-Friendly Interface:', AppInfo.uI),
          const SizedBox(height: 8),
          features('Secure Payments:', AppInfo.payment),
          const SizedBox(height: 20),
          Text('Why EastStay', style: AppText.largeDark),
          const SizedBox(height: 8),
          features('Free to Use:', AppInfo.freeToUser),
          const SizedBox(height: 8),
          features('Flutter-Powered:', AppInfo.flutter),
        ],
      ),
    );
  }

  Text features(String title, String subtitle) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: title,
          style: AppText.mediumdark
              .copyWith(fontSize: 13, color: AppColor.textPrimary)),
      TextSpan(text: subtitle, style: AppText.smallDark)
    ]));
  }
}
