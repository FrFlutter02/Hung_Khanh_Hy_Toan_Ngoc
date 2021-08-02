import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constant_text.dart';
import '../../utils/validator.dart';
import '../../services/user_services.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserServices? userServices;

  LoginBloc({this.userServices}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoginRequested:
        String? emailErrorMessage = await Validator.loginEmailValidator(event);

        if (state.emailErrorMessage.isEmpty &&
            state.passwordErrorMessage.isEmpty) {
          yield LoginInProgress();
        }

        try {
          User? user = await userServices?.logIn(event.email, event.password);
          if (user != null) {
            yield LoginSuccess();
          } else {
            yield LoginFailure(
                emailErrorMessage: emailErrorMessage ?? '',
                passwordErrorMessage: AppText.passwordIsIncorrect,
                unknownErrorMessage: LoginScreenText.loginFailedErrorText);
          }
        } catch (e) {
          yield LoginFailure(unknownErrorMessage: e.toString());
        }
        break;
    }
  }
}
