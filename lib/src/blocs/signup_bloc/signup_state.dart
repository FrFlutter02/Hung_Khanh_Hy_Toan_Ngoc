import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupInProgress extends SignupState {}

class SignupSuccess extends SignupState {}

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
  });

  List<Object> get props => [
        emailErrorMessage,
        fullNameErrorMessage,
        passwordErrorMessage,
        unknownErrorMessage
      ];
}
