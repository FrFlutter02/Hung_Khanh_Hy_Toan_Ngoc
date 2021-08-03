import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

abstract class SignupState extends Equatable {
  final UserModel userModel;
  final String fullNameErrorMessage;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String unknownErrorMessage;

  const SignupState({
    this.userModel = const UserModel(email: '', fullName: '', password: ''),
    this.fullNameErrorMessage = '',
    this.emailErrorMessage = '',
    this.passwordErrorMessage = '',
    this.unknownErrorMessage = '',
  });

  @override
  List<Object> get props => [
        userModel,
        emailErrorMessage,
        fullNameErrorMessage,
        passwordErrorMessage,
        unknownErrorMessage
      ];
}

class SignupInitial extends SignupState {}

class SignupInProgress extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  SignupFailure({
    String fullNameErrorMessage = '',
    String emailErrorMessage = '',
    String passwordErrorMessage = '',
    String unknownErrorMessage = '',
  }) : super(
          fullNameErrorMessage: fullNameErrorMessage,
          emailErrorMessage: emailErrorMessage,
          passwordErrorMessage: passwordErrorMessage,
          unknownErrorMessage: unknownErrorMessage,
        );
}
