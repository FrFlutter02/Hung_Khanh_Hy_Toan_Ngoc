part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  final String fullName;
  final String email;
  final String password;

  const SignupEvent(
      {required this.fullName, required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignupButtonPressed extends SignupEvent {
  final String fullName;
  final String email;
  final String password;

  SignupButtonPressed(
      {required this.fullName, required this.email, required this.password})
      : super(
          fullName: fullName,
          email: email,
          password: password,
        );
}
