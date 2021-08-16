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

class MyProfileModel {
  final String name;
  final String role;
  final List<String> socialMedia;
  final String recipes;
  final String saved;
  final String following;
  final String avatar;
  final List<String> recipeImages;

  MyProfileModel(
      {required this.name,
      required this.role,
      required this.socialMedia,
      required this.recipes,
      required this.saved,
      required this.following,
      required this.avatar,
      required this.recipeImages});
}
