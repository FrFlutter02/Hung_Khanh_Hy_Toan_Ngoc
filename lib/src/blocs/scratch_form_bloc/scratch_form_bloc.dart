import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../validator.dart';

part 'scratch_form_event.dart';
part 'scratch_form_state.dart';

class ScratchFormBloc extends Bloc<ScratchFormEvent, ScratchFormState> {
  final validator = new Validator();

  ScratchFormBloc() : super(ScratchFormIntial());

  @override
  Stream<ScratchFormState> mapEventToState(ScratchFormEvent event) async* {
    switch (event.runtimeType) {
      case ScratchFormEmailChanged:
        yield ScratchFormTextFieldChangeSuccess(
          email: InputField(
              value: event.email, isValid: validator.isValidEmail(event.email)),
          password: state.password,
        );
        break;
      case ScratchFormPasswordChanged:
        yield ScratchFormTextFieldChangeSuccess(
            email: state.email,
            password: InputField(
                value: event.password,
                isValid: validator.isValidPassword(event.password)));
        break;
      case ScratchFormSubmitted:
        if (state.isValidForm) {
          yield ScratchFormInProgress();
          Future.delayed(Duration(seconds: 2));
          yield ScratchFormSubmitSuccess(
            email: state.email,
            password: state.password,
          );
          Future.delayed(Duration(seconds: 0));
          yield ScratchFormIntial();
        } else {
          yield ScratchFormValidateFailure(
              email: state.email, password: state.password);
        }
        break;
    }
  }

  // @override
  // void onChange(Change<ScratchFormState> change) {
  //   print(change);
  //   super.onChange(change);
  // }
}
