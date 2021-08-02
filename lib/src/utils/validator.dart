import '../blocs/signup_bloc/signup_bloc.dart';
import '../constants/constant_text.dart';
import '../services/user_services.dart';

class Validator {
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

  static String? signupFullNameValidator(SignupEvent signupEvent) {
    bool fullNameIsEmpty = signupEvent.userModel.fullName.isEmpty;

    if (fullNameIsEmpty) {
      return AppText.fullNameMustNotEmptyErrorText;
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
}
