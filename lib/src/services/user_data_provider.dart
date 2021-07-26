import '../models/user.dart';

class UserDataProvider {
  static const _users = [
    {
      'fullName': 'Khanh Huynh',
      'email': 'khanh000huynh@gmail.com',
      'password': '123456'
    },
    {
      'fullName': 'Nguyen Van A',
      'email': 'avannguyen@gmail.com',
      'password': '456789'
    },
  ];

  static List<User> get userList {
    return _users.map((user) => User.fromJson(user)).toList();
  }
}
