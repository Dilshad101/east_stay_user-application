part of 'user_bloc.dart';

abstract class UserEvent {}

class FetchUserDataEvent extends UserEvent {
  final String token;

  FetchUserDataEvent({required this.token});
}

class FetchUserTokenEvent extends UserEvent {}

class UserTokenFetchedEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String username;
  final String email;

  UpdateUserEvent({required this.username, required this.email});
}

class ChangePasswordEvent extends UserEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent({required this.oldPassword, required this.newPassword});
}
