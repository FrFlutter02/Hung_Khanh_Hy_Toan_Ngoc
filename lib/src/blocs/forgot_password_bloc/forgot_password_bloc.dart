import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/constant_text.dart';
import '../../services/user_services.dart';
import '../../utils/validator.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial());
  bool isButtonClick = false;
  final UserServices userServices = UserServices();
  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ForgotedPassword:
        String? emailErrorMessage =
            await Validator.forgotPasswordEmailValidator(event);

        yield ForgotPassworFailure(emailErrorMessage: emailErrorMessage ?? '');
        if (state.emailErrorMessage.isEmpty) {
          yield ForgotPasswordProgress();
        }
        if (state.runtimeType != ForgotPassworFailure) {
          userServices.resetPassword(event.email);
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
            content: const Text(ForgotPasswordText.snackbarContentScuess),
          ));
          yield ForgotPasswordSuccess();
        }
        break;
      default:
    }
  }
}
