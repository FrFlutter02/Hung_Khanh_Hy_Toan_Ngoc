import 'constants/constant_text.dart';
import '../src/services/user_services.dart';

class Validator {
  final UserServices userServices = UserServices();

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

  static String? userDidExist(String email) {
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
