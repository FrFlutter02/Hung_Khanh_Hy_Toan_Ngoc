class UserModel {
  final String fullName;
  final String email;
  final String password;

  const UserModel({
    required this.fullName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
    };
  }
}
