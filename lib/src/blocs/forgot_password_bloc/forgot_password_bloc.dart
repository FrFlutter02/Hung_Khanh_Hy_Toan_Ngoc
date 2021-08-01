import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/services/user_services.dart';

import '../../validator.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial(''));
  bool isButtonClick = false;
  final UserServices userServices = UserServices();
  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ForgotedPassword:
        isButtonClick = true;
        if (isButtonClick) {
          isButtonClick = false;
          if (AppText.emailRegex.hasMatch(event.email)) {
            if (await userServices.userDidExist(event.email)) {
              ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(
                content: const Text(ForgotPasswordText.snackbarContentScuess),
              ));
              yield ForgotPassworDoesdemailExist('');
            } else {
              yield ForgotPassworDoesdemailExist(
                  ForgotPasswordText.snackbarContentEmailExist);
            }
          } else {
            yield ForgotPassworDoesdemailExist(AppText.emailInvalidErrorText);
          }
        } else
          isButtonClick = false;
        break;
      default:
    }
  }
}
