import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupRequested extends SignupEvent {
  final UserModel userModel;

  const SignupRequested({this.userModel = const UserModel()});

  @override
  List<Object> get props => [userModel];
}

class SignupErrorDetected extends SignupEvent {
  final String fullNameErrorMessage;
  final String emailErrorMessage;
  final String passwordErrorMessage;

  const SignupErrorDetected(
      {required this.fullNameErrorMessage,
      required this.emailErrorMessage,
      required this.passwordErrorMessage});

  @override
  List<Object> get props =>
      [fullNameErrorMessage, emailErrorMessage, passwordErrorMessage];
}
