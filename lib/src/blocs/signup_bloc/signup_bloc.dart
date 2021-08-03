import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/constant_text.dart';
import '../../services/user_services.dart';
import '../../utils/validator.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserServices? userServices;

  SignupBloc({this.userServices}) : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SignupRequested:
        yield SignupInProgress();

        String? fullNameErrorMessage = Validator.signupFullNameValidator(event);
        String? emailErrorMessage = await Validator.signupEmailValidator(event);
        String? passwordErrorMessage =
            await Validator.signupPasswordValidator(event);

        UserCredential? userCredential = await userServices?.signUp(
            event.userModel.fullName,
            event.userModel.email,
            event.userModel.password);
        if (userCredential != null) {
          yield SignupSuccess();
        } else {
          yield SignupFailure(
              fullNameErrorMessage: fullNameErrorMessage ?? '',
              emailErrorMessage: emailErrorMessage ?? '',
              passwordErrorMessage: passwordErrorMessage ?? '',
              unknownErrorMessage: SignupScreenText.signupFailedErrorText);
        }
        break;
    }
  }
}
