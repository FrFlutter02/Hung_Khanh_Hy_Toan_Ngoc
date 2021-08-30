import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/services/user_services.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserServices _userRepository;

  AuthenticationBloc({required UserServices userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    switch (event.runtimeType) {
      case AuthenticationStarted:
        final isSignedIn = await _userRepository.isSignedIn();
        if (isSignedIn) {
          final firebaseUser = await _userRepository.getUser();
          yield AuthenticationSuccess(firebaseUser);
        } else {
          yield AuthenticationFailure();
        }
        break;
      case AuthenticationLoggedIn:
        yield AuthenticationSuccess(await _userRepository.getUser());
        break;
      case AuthenticationLoggedOut:
        yield AuthenticationFailure();
        _userRepository.signOut();
        break;
      default:
    }
  }
}
