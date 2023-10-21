import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/resources/components/settings_tile.dart';
import 'package:flutter/material.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});
  @override
  Widget build(BuildContext context) {
    final dwidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          children: [
            const SizedBox(height: 20),
            // VendorProfile(),
            Container(
              height: dwidth*.30,
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: dwidth * .30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Richard',
                      style: AppText.xLarge.copyWith(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: .5,color: AppColor.grey,),
            const SizedBox(height: 20),
            AppSettingsTile(
              title: "Your Profile",
              ontap: () {},
              icon: Icons.person_outline_rounded,
            ),

            const SizedBox(height: 10),
            AppSettingsTile(
              title: "App Info",
              ontap: () {},
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 10),
            AppSettingsTile(
              title: "Privacy Policy",
              ontap: () {},
              icon: Icons.lock_outline_rounded,
            ),
            const SizedBox(height: 10),
            AppSettingsTile(
              title: "Terms & condition",
              ontap: () {},
              icon: Icons.verified_user_outlined,
            ),
            const SizedBox(height: 10),
            AppSettingsTile(
              title: "Sign out",
              ontap: () {},
              icon: Icons.logout_rounded,
              removeArrow: true,
            ),
          ],
        ),
      ),
    );
  }
}
