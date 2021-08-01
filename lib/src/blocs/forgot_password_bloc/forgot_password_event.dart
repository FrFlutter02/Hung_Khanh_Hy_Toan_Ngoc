part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  final email;
  final BuildContext context;
  const ForgotPasswordEvent(this.email, this.context);

  @override
  List<Object> get props => [];
}

class ForgotedPassword extends ForgotPasswordEvent {
  final email;
  final BuildContext context;
  ForgotedPassword(this.email, this.context) : super(email, context);
}
