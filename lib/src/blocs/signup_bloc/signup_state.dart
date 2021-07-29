part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupInProgress extends SignupState {}

class SignupSuccess extends SignupState {
  final UserModel user;

  SignupSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});

  @override
  List<Object> get props => [message];
}
