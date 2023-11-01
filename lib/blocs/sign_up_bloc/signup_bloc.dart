import 'dart:async';

import 'package:east_stay/blocs/user_bloc/user_bloc.dart';
import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserBloc userBloc;
  SignupBloc(this.userBloc) : super(SignupInitial()) {
    on<SignupUserEvent>(signupUserEvent);
  }

  FutureOr<void> signupUserEvent(
      SignupUserEvent event, Emitter<SignupState> emit) async {
    final userData = {
      'name': event.name,
      'email': event.email,
      'mobile': event.mobile,
      'password': event.password,
      'confirmPass': event.confirmPass
    };
    emit(SignupLoadingState());
    final valid = await AuthRepo().signupUserValidation(userData);

    if (valid.isRight) {
      final isValid = valid.right;
      if (isValid['status'] == 'success') {
        final either = await AuthRepo().signupUser(userData);
        either.fold(
          (error) {
            emit(SignupErrorState(message: error.message));
          },
          (response) {
            if (response['status'] == 'success') {
              emit(SignupSuccessState('success'));
              SharedPref.instance.setUser(response['token']);
              userBloc.add(FetchUserDataEvent(token: response['token']));
            } else {
              emit(SignupFailuerState(message: response['message']));
            }
          },
        );
      } else {
        emit(SignupFailuerState(message: isValid['message']));
      }
    } else {
      emit(SignupErrorState(message: valid.left.message));
    }
  }
}
