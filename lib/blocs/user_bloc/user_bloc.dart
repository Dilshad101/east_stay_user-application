import 'package:east_stay/data/shared_preferences/shared_pref.dart';
import 'package:east_stay/models/user_model.dart';
import 'package:east_stay/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late User _user;
  UserBloc() : super(UserLoadingState()) {
    on<FetchUserTokenEvent>(_fetchToken);
    on<FetchUserDataEvent>(_fetchData);
    on<UpdateUserEvent>(_updateUser);
    on<ChangePasswordEvent>(_changePassword);
  }

  _fetchData(FetchUserDataEvent event, Emitter<UserState> emit) async {
    final either = await AuthRepo().getUserProfie(event.token);
    either.fold((error) => (error), (response) {
      if (response['status'] == 'failed') {
        emit(UserFetchedFailureState());
      } else {
        _user = User.fromJson(response['userDetails'], event.token);
        emit(UserFetchedSuccessState(user: _user));
      }
    });
  }

  _fetchToken(FetchUserTokenEvent event, Emitter<UserState> emit) {
    final token = SharedPref.instance.getUser();
    if (token == null) {
      emit(UserTokenNotFoundState());
    } else {
      emit(UserTokenFetchedState(token: token));
    }
  }

  _updateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    final userData = {'name': event.username, 'email': event.email};
    final either = await AuthRepo().updateUserProfile(userData, _user.token);
    either.fold((left) {
      emit(UserUpdatedFailedState());
    }, (response) {
      if (response['status'] == 'success') {
        _user.name = event.username;
        _user.email = event.email;
        emit(UserUpdatedSuccessState());
      } else {
        emit(UserUpdatedFailedState());
      }
      emit(UserFetchedSuccessState(user: _user));
    });
  }

  _changePassword(ChangePasswordEvent event, Emitter<UserState> emit) async {
    final data = {
      'password': event.oldPassword,
      'newPass': event.newPassword,
      'confimPass': event.newPassword
    };
    final either = await AuthRepo().changePassword(data);
    either.fold((error) {
      emit(ChangePasswordFailedState());
      emit(UserFetchedSuccessState(user: _user));
    }, (response) {
      if (response['status'] == 'success') {
        emit(ChangePasswordSuccessState());
      } else {
        emit(ChangePasswordFailedState());
      }
      emit(UserFetchedSuccessState(user: _user));
    });
  }
}
