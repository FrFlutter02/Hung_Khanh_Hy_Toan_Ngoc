import '../blocs/login_bloc/login_event.dart';
import '../constants/constant_text.dart';
import '../services/user_services.dart';

class Validator {
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
}
