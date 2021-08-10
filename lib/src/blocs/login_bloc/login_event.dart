import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  const LoginRequested({this.email = '', this.password = ''});

  @override
  List<Object> get props => [email, password];
}
