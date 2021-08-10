import 'package:firebase_core/firebase_core.dart';

import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_event.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cloud_firestore_mock.dart';

class MockUserService extends Mock implements UserServices {}

class MockForgotPassworEvent extends ForgotPasswordEvent {
  MockForgotPassworEvent(String email) : super(email);
}

main() {
  setupCloudFirestoreMocks();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });
  UserServices userServices;
  ForgotPasswordBloc? forgotPasswordBloc;

  setUp(() {
    userServices = MockUserService();
    forgotPasswordBloc = ForgotPasswordBloc();
  });
  tearDown(() {
    forgotPasswordBloc?.close();
  });

  blocTest('emits [] when no event is added',
      build: () => ForgotPasswordBloc(), expect: () => []);
  blocTest(
    'emits [ForgotPassworFailure] is Email must not be empty  when [ForgotPasswordRequested] have null email',
    build: () {
      return ForgotPasswordBloc();
    },
    act: (ForgotPasswordBloc bloc) => bloc.add(ForgotPasswordRequested('')),
    expect: () => [
      ForgotPasswordFailure(
          emailErrorMessage: "Email must not be empty", unknownErrorMessage: '')
    ],
  );

  blocTest(
    'emits [ForgotPassworFailure] have emailErrorMessage is "Please enter a valid email, e.g: john@gmail.com"  when [ForgotPasswordRequested] have email is invalid',
    build: () {
      return ForgotPasswordBloc();
    },
    act: (ForgotPasswordBloc bloc) => bloc.add(ForgotPasswordRequested('aaa@')),
    expect: () => [
      ForgotPasswordFailure(
          emailErrorMessage: 'Please enter a valid email, e.g: john@gmail.com',
          unknownErrorMessage: '')
    ],
  );
  blocTest(
    'emits [ForgotPassworFailure] have  emailErrorMessage is Email did not exist  when [ForgotPasswordRequested] have email is not exist',
    build: () {
      return ForgotPasswordBloc();
    },
    act: (ForgotPasswordBloc bloc) =>
        bloc.add(ForgotPasswordRequested('aaa@gmail.com')),
    expect: () => [
      ForgotPasswordFailure(
          emailErrorMessage: "Email did not exist", unknownErrorMessage: '')
    ],
  );
}
