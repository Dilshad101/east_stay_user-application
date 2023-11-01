import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/blocs/bookin_bloc/booking_bloc.dart';
import 'package:east_stay/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/blocs/login_bloc/login_bloc.dart';
import 'package:east_stay/blocs/search_bloc/search_bloc.dart';
import 'package:east_stay/blocs/sign_up_bloc/signup_bloc.dart';
import 'package:east_stay/blocs/user_bloc/user_bloc.dart';
import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/utils/light_theme.dart';
import 'package:east_stay/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.instance.initSharedPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => CouponBloc()),
        BlocProvider(create: (_) => BookedRoomBloc()),
        BlocProvider(create: (context) => RoomBookingBloc()),
        BlocProvider(create: (context) => LoginBloc(context.read<UserBloc>())),
        BlocProvider(create: (context) => SignupBloc(context.read<UserBloc>())),
        BlocProvider(create: (context) => SearchBloc(context.read<HomeBloc>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const ScreenSplash(),
      ),
    );
  }
}
