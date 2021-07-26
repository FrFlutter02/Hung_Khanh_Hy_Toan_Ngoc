part of 'scratch_form_bloc.dart';

abstract class ScratchFormEvent extends Equatable {
  final String email;
  final String password;

  const ScratchFormEvent({this.email = '', this.password = ''});

  @override
  List<Object> get props => [email, password];
}

class ScratchFormEmailChanged extends ScratchFormEvent {
  final String email;

  const ScratchFormEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class ScratchFormPasswordChanged extends ScratchFormEvent {
  final String password;

  const ScratchFormPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class ScratchFormSubmitted extends ScratchFormEvent {
  const ScratchFormSubmitted();
}
