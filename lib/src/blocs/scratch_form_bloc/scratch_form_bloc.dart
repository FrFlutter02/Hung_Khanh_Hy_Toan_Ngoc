import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../models/user.dart';

part 'scratch_form_event.dart';
part 'scratch_form_state.dart';

class ScratchFormBloc extends Bloc<ScratchFormEvent, ScratchFormState> {
  ScratchFormBloc() : super(SignupIntial());

  @override
  Stream<ScratchFormState> mapEventToState(ScratchFormEvent event) async* {
    switch (event.runtimeType) {
      case SignupEmailChanged:
        final email = Email.dirty(event.email);
        yield SignupEmailChangeSuccess(
          email: email,
          status: Formz.validate([email, state.password]),
        );
        break;
      case SignupPasswordChanged:
        final password = Password.dirty(event.password);
        yield SignupPasswordChangeSuccess(
          password: password,
          status: Formz.validate([state.email, state.password]),
        );
        break;
      case SignupRequested:
        final email = Email.dirty(state.email.value);
        final password = Password.dirty(state.password.value);
        yield SignupLoadSuccess(
          email: email,
          password: password,
          status: Formz.validate([email, password]),
        );
        if (state.status.isValidated) {
          yield SignupFormStatusChangeSuccess(
            status: FormzStatus.submissionInProgress,
          );
          await Future.delayed(Duration(seconds: 2));
          yield SignupFormStatusChangeSuccess(
            status: FormzStatus.submissionSuccess,
          );
        }
        break;
    }
  }
}
