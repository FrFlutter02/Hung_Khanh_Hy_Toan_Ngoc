import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupRequested extends SignupEvent {
  final UserModel userModel;

  const SignupRequested({this.userModel = const UserModel()});

  @override
  List<Object> get props => [userModel];
}
