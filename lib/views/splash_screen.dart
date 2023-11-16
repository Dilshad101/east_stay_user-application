import 'package:east_stay/blocs/booked_room_bloc/booked_room_bloc.dart';
import 'package:east_stay/blocs/home_bloc/home_bloc.dart';
import 'package:east_stay/blocs/user_bloc/user_bloc.dart';
import 'package:east_stay/views/login_screen.dart';
import 'package:east_stay/views/parent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(FetchUserTokenEvent());
    return Scaffold(
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) => listener(context, state),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: body(context),
          ),
        ),
      ),
    );
  }

  listener(BuildContext context, UserState state) {
    if (state is UserTokenNotFoundState) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ScreenLogin()),
      );
    } else if (state is UserTokenFetchedState) {
      context.read<UserBloc>().add(FetchUserDataEvent(token: state.token));
      context.read<BookedRoomBloc>().add(FetchBookedRoomsEvent());
    } else if (state is UserFetchedSuccessState) {
      context.read<HomeBloc>().add(HomeGetAllHotelsEvent());

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ScreenParant()),
      );
    } else if (state is UserFetchedFailureState) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ScreenLogin()));
    }
  }

  List<Widget> body(BuildContext context) {
    return [
      SvgPicture.asset(
        'assets/images/logo v2.svg',
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
      ),
      SizedBox(
        height: MediaQuery.sizeOf(context).height * .10,
        width: MediaQuery.sizeOf(context).height * .10,
      ),
      CircularProgressIndicator(
        color: Colors.grey[700],
      ),
    ];
  }
}
