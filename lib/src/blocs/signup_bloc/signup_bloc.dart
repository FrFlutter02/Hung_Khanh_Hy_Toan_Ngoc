import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../models/user_model.dart';
import '../../services/user_services.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserServices? userServices;

  SignupBloc({this.userServices}) : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SignupRequested:
        yield* mapSignupRequestedToState(event as SignupRequested);
        break;
      case SignupErrorDetected:
        yield* mapSignupErrorDetectedToState(event as SignupErrorDetected);
        break;
    }
  }

  Stream<SignupState> mapSignupRequestedToState(SignupRequested event) async* {
    try {
      yield SignupInProgress();
      await userServices?.signUp(UserModel(
          fullName: event.userModel.fullName,
          email: event.userModel.email,
          password: event.userModel.password));
      yield SignupSuccess();
    } catch (e) {
      yield SignupFailure();
    }
  }

  Stream<SignupState> mapSignupErrorDetectedToState(
      SignupErrorDetected event) async* {
    yield SignupFailure(
      fullNameErrorMessage: event.fullNameErrorMessage,
      emailErrorMessage: event.emailErrorMessage,
      passwordErrorMessage: event.passwordErrorMessage,
    );
  }
}
