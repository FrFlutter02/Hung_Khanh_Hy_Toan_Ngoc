import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';
import '../../services/user_services.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserServices? userServices;

  SignupBloc({this.userServices}) : super(SignupInitial());

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    switch (event.runtimeType) {
      case SignupButtonPressed:
        yield SignupInProgress();
        try {
          await userServices?.signUp(
              event.fullName, event.email, event.password);
          yield SignupSuccess(
              user: UserModel(
                  fullName: event.fullName,
                  email: event.email,
                  password: event.password));
        } catch (e) {
          yield SignupFailure(message: e.toString());
        }
    }
  }
}
