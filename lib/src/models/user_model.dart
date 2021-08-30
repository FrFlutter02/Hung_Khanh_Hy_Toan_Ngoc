import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String avatar;

  const UserModel({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.avatar = '',
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        avatar,
      ];

  Map<String, dynamic> toMap() {
    return {'fullName': fullName, 'email': email, 'avatar': avatar};
  }

  static UserModel fromSnapshot(DocumentSnapshot snapshot) {
    UserModel userModel = UserModel(
      fullName: snapshot['fullName'],
      email: snapshot['email'],
      avatar: snapshot['avatar'],
    );
    return userModel;
  }
}
