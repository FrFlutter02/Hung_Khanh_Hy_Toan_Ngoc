part of 'scratch_form_bloc.dart';

abstract class ScratchFormState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const ScratchFormState(
      {this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.status = FormzStatus.pure});

  @override
  List<Object> get props => [email, password, status];
}

class SignupIntial extends ScratchFormState {
  const SignupIntial();
}

class SignupEmailChangeSuccess extends ScratchFormState {
  const SignupEmailChangeSuccess({
    required Email email,
    required FormzStatus status,
  }) : super(email: email, status: status);
}

class SignupPasswordChangeSuccess extends ScratchFormState {
  const SignupPasswordChangeSuccess({
    required Password password,
    required FormzStatus status,
  }) : super(password: password, status: status);
}

class SignupFormStatusChangeSuccess extends ScratchFormState {
  const SignupFormStatusChangeSuccess({
    required FormzStatus status,
  }) : super(status: status);
}

class SignupLoadSuccess extends ScratchFormState {
  const SignupLoadSuccess({
    required Email email,
    required Password password,
    required FormzStatus status,
  }) : super(email: email, password: password, status: status);
}

class SignupLoadFailure extends ScratchFormState {
  const SignupLoadFailure();
}
