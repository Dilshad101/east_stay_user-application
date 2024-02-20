import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/blocs/login_bloc/login_bloc.dart';
import 'package:east_stay/utils/snack_bar.dart';
import 'package:east_stay/utils/validations.dart';
import 'package:east_stay/views/parent_screen.dart';
import 'package:east_stay/views/signup_screen.dart';
import 'package:east_stay/resources/components/app_textfield.dart';
import 'package:east_stay/resources/components/auth_header_container.dart';
import 'package:east_stay/resources/components/loading_button.dart';
import 'package:east_stay/resources/components/pair_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
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
                  key: loginFormKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Email address',
                          controller: emailController,
                          icon: Icons.person_outline,
                          keyboard: TextInputType.emailAddress,
                          validator: (value) =>
                              Validations.isEmpty(value, 'email'),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: 'Password',
                          icon: Icons.lock_outline_rounded,
                          isObscured: true,
                          keyboard: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value) =>
                              Validations.isEmpty(value, 'password'),
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
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    context.read<HomeBloc>().add(HomeGetAllHotelsEvent());
                    context.read<BookedRoomBloc>().add(FetchBookedRoomsEvent());
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ScreenParant()));
                    MessageViewer.showSnackBar(context, state.message);
                  } else if (state is LoginFailureState) {
                    MessageViewer.showSnackBar(context, state.message, true);
                  } else if (state is ErrorState) {
                    MessageViewer.showSnackBar(context, state.message, true);
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is LoginLoadingState;
                  return LoadingButton(
                    label: 'Login',
                    onTap: () => loginUser(context),
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

  void loginUser(BuildContext context) {
    if (loginFormKey.currentState!.validate()) {
      context.read<LoginBloc>().add(LoginUserEvent(
            email: emailController.text,
            password: passwordController.text,
          ));
    }
  }
}
