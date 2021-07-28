import 'constants/constant_text.dart';

class Validator {
  String? fullNameValidator(String fullName) {
    if (fullName.isEmpty) {
      return AppText.fullNameErrorText;
    }
    return null;
  }

  String? emailValidator(String email) {
    if (!AppText.emailRegex.hasMatch(email)) {
      return AppText.emailErrorText;
    }
    return null;
  }

  String? passwordValidator(String password) {
    if (!AppText.passwordRegex.hasMatch(password)) {
      return AppText.passwordErrorText;
    }
    return null;
  }
}
