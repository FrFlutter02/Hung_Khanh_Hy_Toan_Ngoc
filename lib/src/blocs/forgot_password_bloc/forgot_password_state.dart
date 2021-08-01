part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  final String validationDidExist;

  const ForgotPasswordState(this.validationDidExist);

  @override
  List<Object> get props => [this.validationDidExist];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  final String validationDidExist;

  ForgotPasswordInitial(this.validationDidExist) : super(validationDidExist);
  List<Object> get props => [this.validationDidExist];
}

class ForgotPassworDoesdemailExist extends ForgotPasswordState {
  final String validationDidExist;

  ForgotPassworDoesdemailExist(this.validationDidExist)
      : super(validationDidExist);
  List<Object> get props => [this.validationDidExist];
}
