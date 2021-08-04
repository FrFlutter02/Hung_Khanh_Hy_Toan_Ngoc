import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  final String email;
  final String emailErrorMessage;
  final String unknownErrorMessage;
  const ForgotPasswordState(
      {this.email = '',
      this.emailErrorMessage = '',
      this.unknownErrorMessage = ''});
  @override
  List<Object> get props => [email, emailErrorMessage, unknownErrorMessage];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordInProgress extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPassworFailure extends ForgotPasswordState {
  ForgotPassworFailure({
    String emailErrorMessage = '',
    String unknownErrorMessage = '',
  }) : super(
          emailErrorMessage: emailErrorMessage,
          unknownErrorMessage: unknownErrorMessage,
        );
  @override
  List<Object> get props => [email, emailErrorMessage, unknownErrorMessage];
}
