part of 'signup_bloc.dart';

abstract class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoadingState extends SignupState {}

final class SignupSuccessState extends SignupState {
  final String message;

  SignupSuccessState(this.message);
}

final class SignupFailuerState extends SignupState {
  final String message;

  SignupFailuerState({required this.message});
}

final class SignupErrorState extends SignupState {
  final String message;

  SignupErrorState({required this.message});
}
