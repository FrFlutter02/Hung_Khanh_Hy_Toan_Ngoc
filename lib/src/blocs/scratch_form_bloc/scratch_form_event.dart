part of 'scratch_form_bloc.dart';

abstract class ScratchFormEvent extends Equatable {
  final String email;
  final String password;

  const ScratchFormEvent({this.email = '', this.password = ''});

  @override
  List<Object> get props => [];
}

class SignupEmailChanged extends ScratchFormEvent {
  final String email;

  const SignupEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class SignupPasswordChanged extends ScratchFormEvent {
  final String password;

  const SignupPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class SignupRequested extends ScratchFormEvent {
  const SignupRequested();
}
