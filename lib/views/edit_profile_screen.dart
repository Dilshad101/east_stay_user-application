import 'package:east_stay/blocs/user_bloc/user_bloc.dart';
import 'package:east_stay/models/user_model.dart';
import 'package:east_stay/resources/components/app_textfield.dart';
import 'package:east_stay/resources/components/button.dart';
import 'package:east_stay/resources/components/loding_button.dart';
import 'package:east_stay/resources/constants/text_style.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:east_stay/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenEditProfile extends StatelessWidget {
  ScreenEditProfile({super.key, required this.user});
  final User user;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final newPasswordController = TextEditingController();

  final _passwordFormKey = GlobalKey<FormState>();
  final _userFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    setValues(user);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _userFormKey,
          child: ListView(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * .1),
              AppTextField(
                icon: Icons.person_2_outlined,
                label: 'User Name',
                controller: nameController,
                validator: (value) => Validations.isEmpty(value, 'User Name'),
              ),
              const SizedBox(height: 20),
              AppTextField(
                icon: Icons.email_outlined,
                label: 'Email',
                controller: emailController,
                validator: (value) => Validations.isEmail(value),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => showChangePasswordBottomSheet(context),
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Change password',
                      style: AppText.smallDark
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<UserBloc, UserState>(
                buildWhen: (previous, current) => current is! UserActionState,
                listenWhen: (previous, current) => current is UserActionState,
                listener: (context, state) {
                  if (state is UserUpdatedSuccessState) {
                    MessageViewer.showSnackBar(
                        context, 'Profile updated successfully');
                  } else if (state is UserUpdatedFailedState) {
                    MessageViewer.showSnackBar(
                        context, 'failed to update Profile');
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is UserLoadingState;
                  return LoadingButton(
                    label: 'Proceed',
                    onTap: () {
                      if (_userFormKey.currentState!.validate()) {
                        context.read<UserBloc>().add(UpdateUserEvent(
                            username: nameController.text,
                            email: emailController.text));
                      }
                    },
                    isLoading: isLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showChangePasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      backgroundColor: Colors.white,
      isScrollControlled: true, // Important
      context: context,
      builder: (context) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _passwordFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text('Change Password', style: AppText.xLarge),
              const SizedBox(height: 15),
              AppTextField(
                  icon: Icons.lock_outline_rounded,
                  label: 'Old Password',
                  controller: passwordController,
                  validator: (value) =>
                      Validations.isEmpty(value, 'Old Password')),
              const SizedBox(height: 15),
              AppTextField(
                icon: Icons.lock_outline_rounded,
                label: 'New Password',
                controller: newPasswordController,
                validator: (value) => Validations.isPassword(value),
                autoValidate: false,
              ),
              const SizedBox(height: 15),
              AppTextField(
                icon: Icons.person_2_outlined,
                label: 'Confirm Password',
                validator: (value) => Validations.isPasswordMatch(
                    value, newPasswordController.text),
                controller: confirmPassController,
                autoValidate: false,
              ),
              const SizedBox(height: 15),
              BlocConsumer<UserBloc, UserState>(
                buildWhen: (previous, current) => current is! UserActionState,
                listenWhen: (previous, current) => current is UserActionState,
                listener: (context, state) {
                  if (state is ChangePasswordSuccessState) {
                    Navigator.pop(context);
                    MessageViewer.showSnackBar(
                        context, 'Password changed successfully');
                  } else if (state is ChangePasswordFailedState) {
                    MessageViewer.showSnackBar(
                        context, 'Failed to change password');
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    label: 'Done',
                    onTap: () {
                      if (_passwordFormKey.currentState!.validate()) {
                        context.read<UserBloc>().add(ChangePasswordEvent(
                            oldPassword: passwordController.text,
                            newPassword: newPasswordController.text));
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              AnimatedContainer(
                duration: const Duration(microseconds: 200),
                // curve: Curves.linear,
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setValues(User user) {
    nameController.text = user.name;
    emailController.text = user.email;
  }
}
