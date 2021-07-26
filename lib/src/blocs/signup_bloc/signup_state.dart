import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/user.dart';

abstract class SignupState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const SignupState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  @override
  List<Object> get props => [email, password, status];
}

class SignupIntial extends SignupState {
  const SignupIntial();
}

class SignupEmailChangeSuccess extends SignupState {
  const SignupEmailChangeSuccess({
    required Email email,
    required FormzStatus status,
  }) : super(email: email, status: status);
}

class SignupPasswordChangeSuccess extends SignupState {
  const SignupPasswordChangeSuccess({
    required Password password,
    required FormzStatus status,
  }) : super(password: password, status: status);
}

class SignupFormStatusChangeSuccess extends SignupState {
  const SignupFormStatusChangeSuccess({
    required FormzStatus status,
  }) : super(status: status);
}

class SignupLoadSuccess extends SignupState {
  const SignupLoadSuccess({
    required Email email,
    required Password password,
    required FormzStatus status,
  });
}

class SignupLoadFailure extends SignupState {
  const SignupLoadFailure();
}
