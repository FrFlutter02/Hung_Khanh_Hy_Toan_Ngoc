import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constant_text.dart';
import '../../models/user_model.dart';
import '../../services/user_services.dart';
import '../../utils/validator.dart';
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
        String emailErrorMessage = await Validator.validateLoginEmail(event);
        String passwordErrorMessage =
            await Validator.validateLoginPassword(event);

        try {
          yield LoginInProgress();
          UserModel userModel = UserModel(
              email: event.userModel.email, password: event.userModel.password);
          final firebaseUser = await userServices?.logIn(userModel);

          yield LoginSuccess(user: firebaseUser);
        } catch (e) {
          yield LoginFailure(
              emailErrorMessage: emailErrorMessage,
              passwordErrorMessage: passwordErrorMessage.isNotEmpty
                  ? passwordErrorMessage
                  : AppText.passwordIsIncorrect);
        }
        break;
    }
  }
}
