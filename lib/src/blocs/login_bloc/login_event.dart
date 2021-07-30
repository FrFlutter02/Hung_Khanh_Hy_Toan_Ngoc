part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password})
      : super(email: email, password: password);
}
