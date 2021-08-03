import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';

abstract class SignupEvent extends Equatable {
  final UserModel userModel;

  const SignupEvent(
      {this.userModel =
          const UserModel(fullName: '', email: '', password: '')});

  @override
  List<Object> get props => [userModel];
}

class SignupRequested extends SignupEvent {
  const SignupRequested({required UserModel userModel})
      : super(userModel: userModel);
}
