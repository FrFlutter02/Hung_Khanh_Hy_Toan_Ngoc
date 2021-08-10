import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constant_text.dart';
import '../../utils/validator.dart';
import '../../services/user_services.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserServices? userServices;

  LoginBloc({this.userServices}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    event as LoginRequested;
    switch (event.runtimeType) {
      case LoginRequested:
        String? emailErrorMessage = await Validator.loginEmailValidator(event);
        String? passwordErrorMessage =
            await Validator.loginPasswordValidator(event);
        try {
          yield LoginInProgress();
          User? user = await userServices?.logIn(event.email, event.password);
          if (user != null) {
            yield LoginSuccess();
          } else {
            yield LoginFailure(
                emailErrorMessage: emailErrorMessage,
                passwordErrorMessage:
                    passwordErrorMessage ?? AppText.passwordIsIncorrect);
          }
        } catch (e) {
          yield LoginFailure();
        }
        break;
    }
  }
}
