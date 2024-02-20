import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/blocs/bookin_bloc/booking_bloc.dart';
import 'package:east_stay/blocs/coupon_bloc/coupon_bloc.dart';
import 'package:east_stay/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/blocs/login_bloc/login_bloc.dart';
import 'package:east_stay/blocs/payment_bloc/payment_bloc.dart';
import 'package:east_stay/blocs/review_bloc/review_bloc.dart';
import 'package:east_stay/blocs/search_bloc/search_bloc.dart';
import 'package:east_stay/blocs/sign_up_bloc/signup_bloc.dart';
import 'package:east_stay/blocs/user_bloc/user_bloc.dart';
import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/utils/light_theme.dart';
import 'package:east_stay/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => CouponBloc()),
        BlocProvider(create: (_) => ReviewBloc()),
        BlocProvider(create: (_) => BookedRoomBloc()),
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => PaymentBloc()),
        BlocProvider(create: (context) => LoginBloc(context.read<UserBloc>())),
        BlocProvider(create: (context) => SignupBloc(context.read<UserBloc>())),
        BlocProvider(
            create: (context) => HomeBloc(context.read<FavoriteBloc>())),
        BlocProvider(
            create: (context) =>
                RoomBookingBloc(context.read<BookedRoomBloc>())),
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
