class UserModel {
  final String fullName;
  final String email;
  final String password;

  const UserModel({
    this.fullName = '',
    this.email = '',
    this.password = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
    };
  }
}
