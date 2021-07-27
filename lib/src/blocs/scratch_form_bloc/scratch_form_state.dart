part of 'scratch_form_bloc.dart';

class InputField {
  final String value;
  final bool isValid;

  const InputField({required this.value, required this.isValid});
}

abstract class ScratchFormState extends Equatable {
  final InputField email;
  final InputField password;

  const ScratchFormState({
    this.email = const InputField(value: '', isValid: false),
    this.password = const InputField(value: '', isValid: false),
  });

  bool get isValidForm => email.isValid && password.isValid;

  @override
  List<Object> get props => [email, password, isValidForm];
}

class ScratchFormIntial extends ScratchFormState {
  const ScratchFormIntial();
}

class ScratchFormTextFieldChangeSuccess extends ScratchFormState {
  const ScratchFormTextFieldChangeSuccess({
    required InputField email,
    required InputField password,
  }) : super(email: email, password: password);
}

class ScratchFormInProgress extends ScratchFormState {
  const ScratchFormInProgress();
}

class ScratchFormSubmitSuccess extends ScratchFormState {
  const ScratchFormSubmitSuccess({
    required InputField email,
    required InputField password,
  }) : super(email: email, password: password);
}

class ScratchFormValidateFailure extends ScratchFormState {
  const ScratchFormValidateFailure({
    required InputField email,
    required InputField password,
  }) : super(email: email, password: password);
}
