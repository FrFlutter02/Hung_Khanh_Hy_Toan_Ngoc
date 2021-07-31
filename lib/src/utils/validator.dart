import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/services/user_services.dart';

import '../constants/constant_text.dart';

class Validator {
  static String? fullNameValidator(SignupEvent signupEvent) {
    bool fullNameIsEmpty = signupEvent.userModel.fullName.isEmpty;

    if (fullNameIsEmpty) {
      return AppText.fullNameErrorText;
    }
    return null;
  }

  static Future<String?> emailValidator(SignupEvent signupEvent) async {
    final UserServices _userServices = UserServices();
    bool emailAlreadyExists = await _userServices.existsInDatabase(
        'email', signupEvent.userModel.email);
    bool emailIsValid =
        AppText.emailRegex.hasMatch(signupEvent.userModel.email);

    if (emailAlreadyExists) {
      return AppText.emailAlreadyExists;
    }
    if (!emailIsValid) {
      return AppText.emailErrorText;
    }
    return null;
  }

  static Future<String?> passwordValidator(SignupEvent signupEvent) async {
    bool passwordIsValid =
        AppText.passwordRegex.hasMatch(signupEvent.userModel.password);

    if (!passwordIsValid) {
      return AppText.passwordErrorText;
    }
  }
}
