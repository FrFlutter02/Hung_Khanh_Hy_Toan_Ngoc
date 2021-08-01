import 'constants/constant_text.dart';
import '../src/services/user_services.dart';

class Validator {
  final UserServices userServices = UserServices();

  static String? fullNameValidator(String fullName) {
    if (fullName.isEmpty) {
      return AppText.fullNameMustNotEmptyErrorText;
    }
    return null;
  }

  static String? emailValidator(String email) {
    if (!AppText.emailRegex.hasMatch(email)) {
      return AppText.emailInvalidErrorText;
    }
    return null;
  }

  static String userDidExist(String email) {
    if (email.isNotEmpty) {
      if (!AppText.emailRegex.hasMatch(email)) {
        return AppText.emailAlreadyExistsErrorText;
      } else {
        return AppText.emailDidNotExistErrorText;
      }
    }

    return "";
  }

  static String? passwordValidator(String password) {
    if (!AppText.passwordRegex.hasMatch(password)) {
      return AppText.passwordErrorText;
    }
    return null;
  }
}
