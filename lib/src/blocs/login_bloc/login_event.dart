import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginRequested extends LoginEvent {
  LoginRequested({required String email, required String password})
      : super(email: email, password: password);
}
