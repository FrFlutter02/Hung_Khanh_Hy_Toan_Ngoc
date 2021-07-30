import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../constants/constant_text.dart';
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
          UserModel? userModel = await userServices?.signUp(
              event.fullName, event.email, event.password);
          if (userModel != null) {
            yield SignupSuccess(user: userModel);
          } else {
            yield SignupFailure(message: AppText.userAlreadyExist);
          }
        } catch (e) {
          yield SignupFailure(message: e.toString());
        }
    }
  }
}
