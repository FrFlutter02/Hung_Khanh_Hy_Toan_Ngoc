import '../../src/blocs/login_bloc/login_event.dart';
import '../../src/blocs/signup_bloc/signup_event.dart';
import '../../src/constants/constant_text.dart';
import '../../src/services/user_services.dart';
import '../blocs/forgot_password_bloc/forgot_password_event.dart';
import '../constants/constant_text.dart';

class Validator {
  static Future<String?> forgotPasswordEmailValidator(
      ForgotPasswordEvent forgotPasswordEvent) async {
    final UserServices _userServices = UserServices();
    bool emailIsEmpty = forgotPasswordEvent.email.isEmpty;
    bool emailAlreadyExists = await _userServices.existsInDatabase(
        'email', forgotPasswordEvent.email);
    bool emailIsValid =
        SignupScreenText.emailRegex.hasMatch(forgotPasswordEvent.email);
    if (emailIsEmpty) {
      return AppText.emailMustNotBeEmptyErrorText;
    }
    if (!emailIsValid) {
      return AppText.emailInvalidErrorText;
    }
    if (!emailAlreadyExists) {
      return AppText.emailDoesNotExistErrorText;
    }
    return '';
  }

  static Future<String?> loginEmailValidator(
      LoginRequested loginRequested) async {
    final UserServices _userServices = UserServices();
    bool emailAlreadyExists =
        await _userServices.existsInDatabase('email', loginRequested.email);
    bool emailIsEmpty = loginRequested.email.isEmpty;

    if (emailIsEmpty) {
      return AppText.emailMustNotBeEmptyErrorText;
    }

    if (!emailAlreadyExists) {
      return AppText.emailDoesNotExistErrorText;
    }
  }

  static Future<String?> loginPasswordValidator(
      LoginRequested loginRequested) async {
    bool passwordIsEmpty = loginRequested.password.isEmpty;

    if (passwordIsEmpty) {
      return AppText.passwordMustNotBeEmptyErrorText;
    }
  }

  static Future<String> signupEmailValidator(
      SignupRequested signupRequested) async {
    final UserServices _userServices = UserServices();
    bool emailAlreadyExists = await _userServices.existsInDatabase(
        'email', signupRequested.userModel.email);
    bool emailIsValid =
        SignupScreenText.emailRegex.hasMatch(signupRequested.userModel.email);

    if (emailAlreadyExists) {
      return AppText.emailAlreadyExistsErrorText;
    }
    if (!emailIsValid) {
      return AppText.emailInvalidErrorText;
    }

    return '';
  }

  static String signupFullNameValidator(SignupRequested signupRequested) {
    bool fullNameIsEmpty = signupRequested.userModel.fullName.isEmpty;

    if (fullNameIsEmpty) {
      return AppText.fullNameMustNotEmptyErrorText;
    }

    return '';
  }

  static String signupPasswordValidator(SignupRequested signupRequested) {
    bool passwordIsValid = SignupScreenText.passwordRegex
        .hasMatch(signupRequested.userModel.password);

    if (!passwordIsValid) {
      return AppText.passwordErrorText;
    }

    return '';
  }
}
