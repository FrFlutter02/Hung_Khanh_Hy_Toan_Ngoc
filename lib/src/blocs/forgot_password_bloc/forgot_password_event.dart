part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  final String email;
  final BuildContext context;
  const ForgotPasswordEvent(this.email, this.context);

  @override
  List<Object> get props => [email, context];
}

class ForgotedPassword extends ForgotPasswordEvent {
  final String email;
  final BuildContext context;
  ForgotedPassword(this.email, this.context) : super(email, context);
}
