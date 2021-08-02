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

class SignupSuccess extends SignupState {
  SignupSuccess({required UserModel userModel}) : super(userModel: userModel);
}

enum SignupFailureStatus {
  fullNameEmpty,
  emailInvalid,
  emailExists,
  passwordInvalid,
  unknown
}

class SignupFailure extends SignupState {
  final String fullNameErrorMessage;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String unknownErrorMessage;

  SignupFailure({
    this.fullNameErrorMessage = '',
    this.emailErrorMessage = '',
    this.passwordErrorMessage = '',
    this.unknownErrorMessage = '',
  }) : super(
          fullNameErrorMessage: fullNameErrorMessage,
          emailErrorMessage: emailErrorMessage,
          passwordErrorMessage: passwordErrorMessage,
          unknownErrorMessage: unknownErrorMessage,
        );
}
