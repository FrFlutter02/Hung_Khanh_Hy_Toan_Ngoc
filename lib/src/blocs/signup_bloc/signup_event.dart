import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  final String email;
  final String password;

  const SignupEvent({this.email = '', this.password = ''});

  @override
  List<Object> get props => [];
}

class SignupEmailChanged extends SignupEvent {
  final String email;

  const SignupEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class SignupPasswordChanged extends SignupEvent {
  final String password;

  const SignupPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class SignupRequested extends SignupEvent {
  const SignupRequested();
}
