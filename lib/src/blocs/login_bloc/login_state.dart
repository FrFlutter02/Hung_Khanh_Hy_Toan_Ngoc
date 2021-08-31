import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final UserModel userModel;
  final String emailErrorMessage;
  final String passwordErrorMessage;

  const LoginFailure({
    this.userModel = const UserModel(),
    this.emailErrorMessage = '',
    this.passwordErrorMessage = '',
  });

  @override
  List<Object> get props => [
        emailErrorMessage,
        passwordErrorMessage,
      ];
}
