part of 'forgotpassword_bloc.dart';

abstract class ForgotpasswordEvent extends Equatable {
  final String email;

  const ForgotpasswordEvent(this.email);

  @override
  List<Object> get props => [this.email];
}

class Forgotedpassword extends ForgotpasswordEvent {
  final BuildContext context;
  final String email;
  const Forgotedpassword(this.email, this.context) : super(email);
}
