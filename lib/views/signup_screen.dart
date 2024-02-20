import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/blocs/sign_up_bloc/signup_bloc.dart';
import 'package:east_stay/resources/components/loading_button.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:east_stay/utils/validations.dart';
import 'package:east_stay/resources/components/app_textfield.dart';
import 'package:east_stay/resources/components/auth_header_container.dart';
import 'package:east_stay/resources/components/pair_text.dart';
import 'package:east_stay/views/login_screen.dart';
import 'package:east_stay/views/parent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSignup extends StatelessWidget {
  ScreenSignup({super.key});
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _signupKey = GlobalKey<FormState>();
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
                child: Form(
                  key: _signupKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'User Name',
                          controller: nameController,
                          icon: Icons.person_outline,
                          keyboard: TextInputType.name,
                          validator: (value) =>
                              Validations.isEmpty(value, 'User Name'),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Mobile Number',
                          icon: Icons.person_outline,
                          controller: mobileController,
                          keyboard: TextInputType.number,
                          validator: (value) =>
                              Validations.isNumber(value, 'Mobile Number'),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Email',
                          icon: Icons.email,
                          controller: emailController,
                          keyboard: TextInputType.emailAddress,
                          validator: (value) => Validations.isEmail(value),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Password',
                          icon: Icons.lock,
                          controller: passwordController,
                          isObscured: true,
                          validator: (value) =>
                              Validations.isEmpty(value, 'password'),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Confirm Password',
                          icon: Icons.lock,
                          isObscured: true,
                          controller: confirmPasswordController,
                          validator: (value) => Validations.isPasswordMatch(
                            value,
                            passwordController.text,
                          ),
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
              ),
              BlocConsumer<SignupBloc, SignupState>(builder: (context, state) {
                bool isLoading = state is SignupLoadingState ? true : false;
                return LoadingButton(
                  label: 'Sign up',
                  margin: 20,
                  isLoading: isLoading,
                  onTap: () => singupUser(context),
                );
              }, listener: (context, state) {
                if (state is SignupFailuerState) {
                  MessageViewer.showSnackBar(context, state.message, true);
                } else if (state is SignupErrorState) {
                  MessageViewer.showSnackBar(context, state.message, true);
                } else if (state is SignupSuccessState) {
                  context.read<HomeBloc>().add(HomeGetAllHotelsEvent());
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ScreenParant()));
                  MessageViewer.showSnackBar(
                    context,
                    'Account Created Successfully',
                  );
                }
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void singupUser(BuildContext context) {
    if (_signupKey.currentState!.validate()) {
      context.read<SignupBloc>().add(
            SignupUserEvent(
              name: nameController.text,
              mobile: mobileController.text,
              email: emailController.text,
              password: passwordController.text,
              confirmPass: confirmPasswordController.text,
            ),
          );
    }
  }
}
