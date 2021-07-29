part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  final String fullName;
  final String email;
  final String password;

  const SignupEvent(
      {required this.fullName, required this.email, required this.password});

  @override
  List<Object> get props => [fullName, email, password];
}

class SignupButtonPressed extends SignupEvent {
  SignupButtonPressed(
      {required String fullName,
      required String email,
      required String password})
      : super(fullName: fullName, email: email, password: password);
}
