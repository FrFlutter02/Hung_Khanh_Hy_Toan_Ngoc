import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/user.dart';

part 'scratch_form_event.dart';
part 'scratch_form_state.dart';

class ScratchFormBloc extends Bloc<ScratchFormEvent, ScratchFormState> {
  ScratchFormBloc() : super(ScratchFormIntial());

  @override
  Stream<ScratchFormState> mapEventToState(ScratchFormEvent event) async* {
    switch (event.runtimeType) {
      case ScratchFormEmailChanged:
        final email = Email.dirty(event.email);
        yield ScratchFormEmailChangeSuccess(
          email: email,
          status: Formz.validate([email, state.password]),
        );
        break;
      case ScratchFormPasswordChanged:
        final password = Password.dirty(event.password);
        yield ScratchFormPasswordChangeSuccess(
          password: password,
          status: Formz.validate([state.email, password]),
        );
        break;
      case ScratchFormSubmitted:
        final email = Email.dirty(state.email.value);
        final password = Password.dirty(state.password.value);
        yield ScratchFormLoadSuccess(
          email: email,
          password: password,
          status: Formz.validate([email, password]),
        );
        if (state.status.isValidated) {
          yield ScratchFormFormStatusChangeSuccess(
            status: FormzStatus.submissionInProgress,
          );
          await Future.delayed(Duration(seconds: 2));
          yield ScratchFormFormStatusChangeSuccess(
            status: FormzStatus.submissionSuccess,
          );
          print("success");
        }
        break;
    }
  }
}
