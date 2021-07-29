import 'package:mobile_app/src/constants/constant_text.dart';

import '../constants/constant_text.dart';

class Validator {
  static String? fullNameValidator(String fullName) {
    if (fullName.isEmpty) {
      return AppText.fullNameErrorText;
    }
    return null;
  }

  static String? emailValidator(String email) {
    if (!AppText.emailRegex.hasMatch(email)) {
      return AppText.emailErrorText;
    }
    return null;
  }

  static String? passwordValidator(String password) {
    if (!AppText.passwordRegex.hasMatch(password)) {
      return AppText.passwordErrorText;
    }
    return null;
  }
}
