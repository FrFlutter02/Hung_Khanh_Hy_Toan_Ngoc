import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginRequested extends LoginEvent {
  final UserModel userModel;

  const LoginRequested({this.userModel = const UserModel()});

  @override
  List<Object> get props => [userModel];
}

class LogInGetUserRequested extends LoginEvent {
  @override
  List<Object> get props => [];
}
