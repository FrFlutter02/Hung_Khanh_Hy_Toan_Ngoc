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

class ScratchFormIntial extends ScratchFormState {
  const ScratchFormIntial();
}

class ScratchFormEmailChangeSuccess extends ScratchFormState {
  const ScratchFormEmailChangeSuccess({
    required Email email,
    required FormzStatus status,
  }) : super(email: email, status: status);
}

class ScratchFormPasswordChangeSuccess extends ScratchFormState {
  const ScratchFormPasswordChangeSuccess({
    required Password password,
    required FormzStatus status,
  }) : super(password: password, status: status);
}

class ScratchFormFormStatusChangeSuccess extends ScratchFormState {
  const ScratchFormFormStatusChangeSuccess({
    required FormzStatus status,
  }) : super(status: status);
}

class ScratchFormLoadSuccess extends ScratchFormState {
  const ScratchFormLoadSuccess({
    required Email email,
    required Password password,
    required FormzStatus status,
  }) : super(email: email, password: password, status: status);
}

class ScratchFormLoadFailure extends ScratchFormState {
  const ScratchFormLoadFailure();
}
