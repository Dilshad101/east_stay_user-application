import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/blocs/user_bloc/user_bloc.dart';
import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/resources/constants/colors.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/utils/alert_dialoge.dart';
import 'package:east_stay/views/app_info_screen.dart';
import 'package:east_stay/views/edit_profile_screen.dart';
import 'package:east_stay/views/help_screen.dart';
import 'package:east_stay/views/login_screen.dart';
import 'package:east_stay/views/privacy_policy_screen.dart';
import 'package:east_stay/views/terms_and_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            settingsTile(
              Icons.privacy_tip_outlined,
              'App Info',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScreenAppInfo())),
            ),
            Divider(color: Colors.grey[200], thickness: 2),
            settingsTile(
              Icons.note_outlined,
              'Terms & Conditions',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScreenTermsAndCondition())),
            ),
            settingsTile(
              Icons.import_contacts_outlined,
              'Privacy & policies',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScreenPrivacyPolicy())),
            ),
            settingsTile(
              Icons.help_center_outlined,
              'Help',
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ScreenHelp())),
            ),
            Divider(color: Colors.grey[200], thickness: 2),
            settingsTile(
              Icons.logout_sharp,
              'Sign out',
              hideSuffix: true,
              onTap: () {
                alertPopup(
                  context: context,
                  title: 'Sign out',
                  proceedText: 'Sign out',
                  content: 'Are you sure you want to sign out',
                  onCancel: () => Navigator.pop(context),
                  onOkey: () {
                    context.read<BookedRoomBloc>().add(ResetBookedRoomsEvent());
                    SharedPref.instance.logOutUser();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => ScreenLogin()),
                        (route) => false);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsTile(IconData leading, String title,
      {VoidCallback? onTap, bool hideSuffix = false}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        width: double.maxFinite,
        child: Row(
          children: [
            const SizedBox(width: 20),
            Icon(leading, size: 20, color: Colors.black),
            const SizedBox(width: 15),
            Expanded(child: Text(title, style: AppText.mediumdark)),
            hideSuffix
                ? const SizedBox()
                : const Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 24,
                    color: AppColor.secondaryColor,
                  ),
            const SizedBox(width: 20),
          ],
        ),
      ),
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
