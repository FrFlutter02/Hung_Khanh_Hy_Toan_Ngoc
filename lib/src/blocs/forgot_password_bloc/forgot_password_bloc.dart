import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../services/user_services.dart';
import '../../utils/validator.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial());

  final UserServices userServices = UserServices();
  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ForgotPasswordRequested:
        String? emailErrorMessage =
            await Validator.forgotPasswordEmailValidator(event);

        yield ForgotPassworFailure(emailErrorMessage: emailErrorMessage ?? '');

        if ((state as ForgotPassworFailure).emailErrorMessage.isEmpty) {
          yield ForgotPasswordInProgress();
        }
        if (state.runtimeType != ForgotPassworFailure) {
          userServices.resetPassword(event.email);
          Navigator.of(event.context).pushNamed('/loginScreen');
          yield ForgotPasswordSuccess();
        }
        break;
      default:
    }
  }
}
