class UserModel {
  const UserModel({
    required this.fullName,
    required this.email,
    required this.password,
  });
  final String fullName;
  final String email;
  final String password;
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }
}
