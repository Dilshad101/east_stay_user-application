import 'dart:async';

import 'package:east_stay/blocs/user_bloc/user_bloc.dart';
import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserBloc userBloc;
  LoginBloc(this.userBloc) : super(InitialState()) {
    on<LoginUserEvent>(loginUserEvent);
  }

  FutureOr<void> loginUserEvent(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    final userData = {'email': event.email, 'password': event.password};
    emit(LoginLoadingState());
    final either = await AuthRepo().loginUser(userData);
    either.fold(
      (error) => emit(ErrorState(message: error.message)),
      (response) {
        if (response['status'] == 'success') {
          emit(LoginSuccessState(message: response['message']));
          SharedPref.instance.setUser(response['token']);
          userBloc.add(FetchUserDataEvent(token: response['token']));
        } else {
          emit(LoginFailureState(message: response['message']));
        }
      },
    );
  }
}
