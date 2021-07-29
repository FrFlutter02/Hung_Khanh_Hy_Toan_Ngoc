import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/src/services/user_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserServices userServices;

  AuthBloc({required this.userServices}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    switch (event.runtimeType) {
      case AppLoaded:
        try {
          var isLoggedIn = await userServices.isLoggedIn();
          if (isLoggedIn) {
            var currentUser = await userServices.getCurrentUser();
            yield AuthenticateState(user: currentUser!);
          } else {
            yield UnauthenticateState();
          }
        } catch (e) {
          yield UnauthenticateState();
        }
        break;
    }
  }
}
