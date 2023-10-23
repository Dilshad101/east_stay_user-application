part of 'signup_bloc.dart';

abstract class SignupEvent {}

class SignupUserEvent extends SignupEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPass;
  final String mobile;

  SignupUserEvent({
    required this.name,
    required this.confirmPass,
    required this.mobile,
    required this.email,
    required this.password,
  });
}
