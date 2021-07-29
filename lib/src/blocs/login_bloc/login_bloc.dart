import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/src/services/user_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserServices? userServices;

  LoginBloc({this.userServices}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoginButtonPressed:
        yield LoginInProgress();
        try {
          var user = await userServices?.logIn(event.email, event.password);
          yield LoginSuccess(user: user!);
        } catch (e) {
          yield LoginFailure(message: e.toString());
        }
    }
  }
}
