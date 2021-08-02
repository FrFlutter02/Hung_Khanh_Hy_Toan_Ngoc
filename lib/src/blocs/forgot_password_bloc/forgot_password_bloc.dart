import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_text.dart';

import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/utils/validator.dart';

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

        // ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
        //   content: const Text(ForgotPasswordText.snackbarContentScuess),
        // ));
        // if (event.email != '') {
        //   if (AppText.emailRegex.hasMatch(event.email)) {
        //     if (await userServices.userDidExist(event.email)) {
        //       userServices.updateUser(event.email);
        //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
        //         content: const Text(ForgotPasswordText.snackbarContentScuess),
        //       ));

        //       yield ForgotPassworDoesEmailExist('');
        //     } else {
        //       yield ForgotPassworDoesEmailExist(
        //           ForgotPasswordText.snackbarContentEmailExist);
        //     }
        //   } else {
        //     yield ForgotPassworDoesEmailExist(AppText.emailInvalidErrorText);
        //   }
        // } else {
        //   yield ForgotPassworDoesEmailExist("Please Enter email");
        // }

        break;
      default:
    }
  }
}
