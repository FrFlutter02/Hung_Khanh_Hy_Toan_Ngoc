import '../blocs/signup_bloc/signup_event.dart';
import '../constants/constant_text.dart';
import '../services/user_services.dart';

class Validator {
  static String? signupFullNameValidator(SignupRequested signupRequested) {
    bool fullNameIsEmpty = signupRequested.userModel.fullName.isEmpty;

    if (fullNameIsEmpty) {
      return AppText.fullNameMustNotEmptyErrorText;
    }
  }

  static Future<String?> signupEmailValidator(
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
  }

  static String? signupPasswordValidator(SignupRequested signupRequested) {
    bool passwordIsValid = SignupScreenText.passwordRegex
        .hasMatch(signupRequested.userModel.password);

    if (!passwordIsValid) {
      return AppText.passwordErrorText;
    }
  }
}
