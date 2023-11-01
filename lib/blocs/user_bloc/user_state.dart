part of 'user_bloc.dart';

abstract class UserState {}

abstract class UserActionState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserFetchedSuccessState extends UserState {
  final User user;

  UserFetchedSuccessState({required this.user});
}

final class UserTokenFetchedState extends UserState {
  final String token;

  UserTokenFetchedState({required this.token});
}

final class UserFetchedFailureState extends UserState {}

final class UserTokenNotFoundState extends UserState {}

class UserUpdatedSuccessState extends UserActionState {}

class UserUpdatedFailedState extends UserActionState {}

class ChangePasswordFailedState extends UserActionState {}

class ChangePasswordSuccessState extends UserActionState {}
