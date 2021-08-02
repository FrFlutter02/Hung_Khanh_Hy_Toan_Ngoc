import '../blocs/login_bloc/login_event.dart';
import '../blocs/signup_bloc/signup_event.dart';
import '../constants/constant_text.dart';
import '../services/user_services.dart';

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
        SignupScreenText.emailRegex.hasMatch(signupEvent.userModel.email);

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
        SignupScreenText.passwordRegex.hasMatch(signupEvent.userModel.password);

    if (!passwordIsValid) {
      return AppText.passwordErrorText;
    }
  }

  static Future<String?> loginEmailValidator(LoginEvent loginEvent) async {
    final UserServices _userServices = UserServices();
    bool emailAlreadyExists =
        await _userServices.existsInDatabase('email', loginEvent.email);
    bool emailIsEmpty = loginEvent.email.isEmpty;
    if (emailIsEmpty) {
      return AppText.emailMustNotBeEmptyErrorText;
    }
    if (!emailAlreadyExists) {
      return AppText.emailDoesNotExistErrorText;
    }
  }

  static Future<String?> loginPasswordValidator(LoginEvent loginEvent) async {
    final UserServices _userServices = UserServices();
    bool passwordIsEmpty = loginEvent.password.isEmpty;
    bool passwordAlreadyExists = await _userServices.passwordExistsInDatabase(
        loginEvent.email, loginEvent.password);
    if (passwordIsEmpty) {
      return AppText.passwordMustNotBeEmptyErrorText;
    }
    if (!passwordAlreadyExists) {
      return AppText.passwordIsIncorrect;
    }
  }
}
