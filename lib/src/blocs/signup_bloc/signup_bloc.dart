import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../constants/constant_text.dart';
import '../../models/user_model.dart';
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
        String? fullNameErrorMessage = Validator.signupFullNameValidator(event);
        String? emailErrorMessage = await Validator.signupEmailValidator(event);
        String? passwordErrorMessage =
            await Validator.signupPasswordValidator(event);

        yield SignupFailure(
            fullNameErrorMessage: fullNameErrorMessage ?? '',
            emailErrorMessage: emailErrorMessage ?? '',
            passwordErrorMessage: passwordErrorMessage ?? '');

        if (state.fullNameErrorMessage.isEmpty &&
            state.emailErrorMessage.isEmpty &&
            state.passwordErrorMessage.isEmpty) {
          yield SignupInProgress();
        }

        if (state.runtimeType != SignupFailure) {
          try {
            UserModel? userModel = await userServices?.signUp(
                event.userModel.fullName,
                event.userModel.email,
                event.userModel.password);
            if (userModel != null) {
              yield SignupSuccess(userModel: userModel);
            } else {
              yield SignupFailure(
                  unknownErrorMessage: SignupScreenText.signupFailedErrorText);
            }
          } catch (e) {
            yield SignupFailure(unknownErrorMessage: e.toString());
          }
        }
        break;
    }
  }
}
