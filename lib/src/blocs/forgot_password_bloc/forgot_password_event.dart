import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  final String email;

  const ForgotPasswordEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ForgotPasswordRequested extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordRequested(
    this.email,
  ) : super(email);
}
