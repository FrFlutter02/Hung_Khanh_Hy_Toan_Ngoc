import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/services/user_services.dart';

import '../constants/constant_text.dart';

class Validator {
  static String? signupFullNameValidator(SignupEvent signupEvent) {
    bool fullNameIsEmpty = signupEvent.userModel.fullName.isEmpty;

    if (fullNameIsEmpty) {
      return AppText.fullNameMustNotEmptyErrorText;
    }
  }

  static Future<String?> signupEmailValidator(SignupEvent signupEvent) async {
    final UserServices _userServices = UserServices();
    bool emailAlreadyExists = await _userServices.existsInDatabase(
        'email', signupEvent.userModel.email);
    bool emailIsValid =
        AppText.emailRegex.hasMatch(signupEvent.userModel.email);

    if (emailAlreadyExists) {
      return AppText.emailAlreadyExistsErrorText;
    }
    if (!emailIsValid) {
      return AppText.emailInvalidErrorText;
    }
  }

  static Future<String?> signupPasswordValidator(
      SignupEvent signupEvent) async {
    bool passwordIsValid =
        AppText.passwordRegex.hasMatch(signupEvent.userModel.password);

    if (!passwordIsValid) {
      return AppText.passwordErrorText;
    }
  }

  static Future<String?> forgotPasswordEmailValidator(
      ForgotPasswordEvent forgotPasswordEvent) async {
    final UserServices _userServices = UserServices();
    bool emailIsEmpty = forgotPasswordEvent.email.isEmpty;
    bool emailAlreadyExists = await _userServices.existsInDatabase(
        'email', forgotPasswordEvent.email);
    bool emailIsValid = AppText.emailRegex.hasMatch(forgotPasswordEvent.email);
    if (emailIsEmpty) {
      return AppText.emailMustNotEmptyErrorText;
    }
    if (!emailIsValid) {
      return AppText.emailInvalidErrorText;
    }
    if (!emailAlreadyExists) {
      return AppText.emailDidNotExistErrorText;
    }
  }
}
