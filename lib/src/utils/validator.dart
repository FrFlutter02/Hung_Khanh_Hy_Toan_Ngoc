import '../blocs/forgot_password_bloc/forgot_password_event.dart';
import '../../src/constants/constant_text.dart';
import '../../src/services/user_services.dart';
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
