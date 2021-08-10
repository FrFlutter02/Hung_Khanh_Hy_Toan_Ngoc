import 'package:bloc/bloc.dart';

import '../../services/user_services.dart';
import '../../utils/validator.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  UserServices? userServices;

  ForgotPasswordBloc({this.userServices}) : super(ForgotPasswordInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ForgotPasswordRequested:
        String? emailErrorMessage =
            await Validator.forgotPasswordEmailValidator(event);
        yield ForgotPasswordFailure(emailErrorMessage: emailErrorMessage ?? '');
        if ((state as ForgotPasswordFailure).emailErrorMessage.isEmpty) {
          yield ForgotPasswordInProgress();
        }
        if (state.runtimeType != ForgotPasswordFailure) {
          userServices?.resetPassword(event.email);
          yield ForgotPasswordSuccess();
        }
        break;
      default:
    }
  }
}
