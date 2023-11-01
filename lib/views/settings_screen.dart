import 'package:east_stay/blocs/user_bloc/user_bloc.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/views/edit_profile_screen.dart';
import 'package:east_stay/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(top: 0),
          children: [
            userProfile(),
            const SizedBox(height: 20),
            settingsTile(IonIcons.settings_sharp, 'settings'),
            settingsTile(Icons.privacy_tip_outlined, 'App Info'),
            Divider(color: Colors.grey[200], thickness: 2),
            settingsTile(Icons.note_outlined, 'Terms & Conditions'),
            settingsTile(Icons.import_contacts_outlined, 'Privacy & policies'),
            settingsTile(Icons.help_center_outlined, 'Help'),
            Divider(color: Colors.grey[200], thickness: 2),
            settingsTile(
              Icons.logout_sharp,
              'Sign out',
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => ScreenLogin()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  ListTile settingsTile(IconData leading, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(leading, size: 23),
      title: Text(
        title,
        style: AppText.largeDark,
      ),
      trailing: onTap == null
          ? const Icon(
              Icons.keyboard_arrow_right_outlined,
              size: 24,
              color: AppColor.secondaryColor,
            )
          : null,
      onTap: onTap,
    );
  }

  userProfile() {
    return BlocBuilder<UserBloc, UserState>(
      buildWhen: (previous, current) => current is! UserActionState,
      builder: (context, state) {
        if (state is UserFetchedSuccessState) {
          return Container(
            height: MediaQuery.sizeOf(context).height * .2,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/user_background.jpg'),
              fit: BoxFit.cover,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  state.user.name,
                  style: AppText.xLarge
                      .copyWith(color: Colors.grey[200], fontSize: 26),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.user.email,
                        style: AppText.smallLight
                            .copyWith(color: Colors.grey[300]),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ScreenEditProfile(user: state.user),
                        ),
                      ),
                      child: Text('Edit Profile', style: AppText.mediumLight),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
