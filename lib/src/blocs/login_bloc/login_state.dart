import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final String email;
  final String password;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String unknownErrorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.emailErrorMessage = '',
    this.passwordErrorMessage = '',
    this.unknownErrorMessage = '',
  });

  @override
  List<Object> get props => [
        email,
        password,
        emailErrorMessage,
        passwordErrorMessage,
        unknownErrorMessage
      ];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  LoginFailure({
    String emailErrorMessage = '',
    String passwordErrorMessage = '',
    String unknownErrorMessage = '',
  }) : super(
          emailErrorMessage: emailErrorMessage,
          passwordErrorMessage: passwordErrorMessage,
          unknownErrorMessage: unknownErrorMessage,
        );
}
