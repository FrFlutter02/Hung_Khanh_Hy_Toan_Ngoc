import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordInProgress extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String emailErrorMessage;
  final String unknownErrorMessage;
  ForgotPasswordFailure({
    this.emailErrorMessage = '',
    this.unknownErrorMessage = '',
  });
  @override
  List<Object> get props => [emailErrorMessage, unknownErrorMessage];
}
