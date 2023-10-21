import 'package:east_stay/views/login_screen.dart';
import 'package:east_stay/views/root_screen.dart';
import 'package:east_stay/resources/components/app_textfield.dart';
import 'package:east_stay/resources/components/auth_header_container.dart';
import 'package:east_stay/resources/components/button.dart';
import 'package:east_stay/resources/components/pair_text.dart';
import 'package:flutter/material.dart';

class ScreenSignup extends StatelessWidget {
  ScreenSignup({super.key});
  final firstnameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dheight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: dheight,
          child: Column(
            children: [
              const AuthHeader(
                title: 'Sign up',
                subtitle: "Create a account to continue",
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      AppTextField(
                          label: 'First Name',
                          controller: firstnameController,
                          icon: Icons.person_outline),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Last Name',
                        icon: Icons.person_outline,
                        controller: firstnameController,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Email',
                        icon: Icons.email,
                        controller: firstnameController,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Password',
                        icon: Icons.lock,
                        controller: firstnameController,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Confirm Password',
                        icon: Icons.lock,
                        controller: firstnameController,
                      ),
                      const Spacer(),
                      PairText(
                        firstText: 'Already have an account ',
                        secondText: 'Login',
                        onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ScreenLogin(),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              PrimaryButton(
                label: 'Sign up',
                margin: 20,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ScreenRoot()));
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
