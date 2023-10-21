// ignore_for_file: prefer_const_constructors

import 'package:east_stay/controller/sign_in_bloc/login_bloc.dart';
import 'package:east_stay/view/root_screen.dart';
import 'package:east_stay/view/signup_screen.dart';
import 'package:east_stay/widgets/app_textfield.dart';
import 'package:east_stay/widgets/auth_header_container.dart';
import 'package:east_stay/widgets/loding_button.dart';
import 'package:east_stay/widgets/pair_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  final loginController = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              const AuthHeader(
                title: 'Login',
                subtitle: "Login your account with\nemail and password",
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Form(
                  key: loginKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Email address',
                          controller: emailController,
                          icon: Icons.person_outline,
                          validator: (value) => value.toString().isEmpty
                              ? 'Field is empty'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Password',
                          icon: Icons.lock_outline_rounded,
                          controller: passwordController,
                          validator: (value) => value.toString().isEmpty
                              ? 'Field is Empty'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        PairText(
                          firstText: "Don't have an account",
                          secondText: 'Sign up',
                          onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ScreenSignup(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              BlocConsumer<LoginBloc, LoginState>(
                bloc: loginController,
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ScreenRoot()));
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is LoginFailureState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is ErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is LoginLoadingState ? true : false;
                  return LoadingButton(
                    label: 'Login',
                    onTap: loginUser,
                    margin: 20,
                    isLoading: isLoading,
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() {
    if (loginKey.currentState!.validate()) {
      loginController.add(LoginUserEvent(
        email: emailController.text,
        password: passwordController.text,
      ));
    }
  }
}
