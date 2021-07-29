import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'forgotpassword_event.dart';
part 'forgotpassword_state.dart';

class ForgotpasswordBloc
    extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {
  ForgotpasswordBloc() : super(ForgotpasswordInitial());

  @override
  Stream<ForgotpasswordState> mapEventToState(
    ForgotpasswordEvent event,
  ) async* {
    switch (event.runtimeType) {
      case Forgotedpassword:
        event as Forgotedpassword;
        nextPage(event.context);
        if (event.email != "ngiahyiu@gmaill.com") {
          print("mail của Hy");
        }
        break;
      default:
    }
    // TODO: implement mapEventToState
  }

  void nextPage(context) {
    Navigator.of(context).pushNamed('/loginScreen');
  }
}
