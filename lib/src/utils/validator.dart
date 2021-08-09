import '../blocs/signup_bloc/signup_event.dart';
import '../constants/constant_text.dart';
import '../services/user_services.dart';

class RegularExpression {
  static RegExp emailRegex = RegExp(
      r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''');
  static RegExp passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
}

class Validator {
  static String signupFullNameValidator(SignupRequested signupRequested) {
    bool fullNameIsEmpty = signupRequested.userModel.fullName.isEmpty;

    if (fullNameIsEmpty) {
      return AppText.fullNameMustNotEmptyErrorText;
    }

    return '';
  }

  static Future<String> signupEmailValidator(
      SignupRequested signupRequested) async {
    final UserServices _userServices = UserServices();
    bool emailAlreadyExists = await _userServices.existsInDatabase(
        'email', signupRequested.userModel.email);
    bool emailIsValid =
        RegularExpression.emailRegex.hasMatch(signupRequested.userModel.email);

    if (emailAlreadyExists) {
      return AppText.emailAlreadyExistsErrorText;
    }
    if (!emailIsValid) {
      return AppText.emailInvalidErrorText;
    }

    return '';
  }

  static String signupPasswordValidator(SignupRequested signupRequested) {
    bool passwordIsValid = RegularExpression.passwordRegex
        .hasMatch(signupRequested.userModel.password);

    if (!passwordIsValid) {
      return AppText.passwordErrorText;
    }

    return '';
  }
}
