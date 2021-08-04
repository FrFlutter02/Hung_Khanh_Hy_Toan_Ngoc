import '../blocs/login_bloc/login_event.dart';
import '../constants/constant_text.dart';
import '../services/user_services.dart';

class Validator {
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
}
