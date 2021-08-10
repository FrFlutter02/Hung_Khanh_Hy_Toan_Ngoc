import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/models/user_model.dart';

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
        String emailErrorMessage = await Validator.loginEmailValidator(event);
        String passwordErrorMessage =
            await Validator.loginPasswordValidator(event);

        try {
          yield LoginInProgress();
          UserModel userModel = UserModel(
              email: event.userModel.email, password: event.userModel.password);
          await userServices?.logIn(userModel);
          yield LoginSuccess();
        } catch (e) {
          yield LoginFailure(
              emailErrorMessage: emailErrorMessage,
              passwordErrorMessage: passwordErrorMessage.isEmpty
                  ? passwordErrorMessage
                  : AppText.passwordIsIncorrect);
        }
        break;
    }
  }
}
