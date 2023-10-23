import 'package:east_stay/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/blocs/sign_in_bloc/login_bloc.dart';
import 'package:east_stay/blocs/sign_up_bloc/signup_bloc.dart';
import 'package:east_stay/utils/light_theme.dart';
import 'package:east_stay/views/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => SignupBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => CouponBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: ScreenRoot(),
       
      ),
    );
  }
}
