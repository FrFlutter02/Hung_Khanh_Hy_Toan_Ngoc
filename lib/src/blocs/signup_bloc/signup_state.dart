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

  SignupFailure({
    this.fullNameErrorMessage = '',
    this.emailErrorMessage = '',
    this.passwordErrorMessage = '',
  });

  List<Object> get props => [
        emailErrorMessage,
        fullNameErrorMessage,
        passwordErrorMessage,
      ];
}
