import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ForgotPasswordEvent extends Equatable {
  final String email;
  final BuildContext context;
  const ForgotPasswordEvent(this.email, this.context);

  @override
  List<Object> get props => [email, context];
}

class ForgotPasswordRequested extends ForgotPasswordEvent {
  final String email;
  final BuildContext context;
  ForgotPasswordRequested(this.email, this.context) : super(email, context);
}
