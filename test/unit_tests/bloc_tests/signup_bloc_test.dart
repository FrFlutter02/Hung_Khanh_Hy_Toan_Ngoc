import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_event.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_state.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {
  @override
  Future<UserCredential?> signUp(UserModel userModel) async {
    if (userModel.fullName != 'valid' &&
        userModel.email != 'valid' &&
        userModel.password != 'valid') {
      throw Exception();
    }
  }
}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  MockUserServices mockUserServices;
  SignupBloc? signupBloc;

  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  setUp(() async {
    mockUserServices = MockUserServices();
    signupBloc = SignupBloc(userServices: mockUserServices);
  });

  tearDown(() {
    signupBloc?.close();
  });

  blocTest('emits [] when no events is called',
      build: () {
        mockUserServices = MockUserServices();
        return SignupBloc(userServices: mockUserServices);
      },
      expect: () => []);

  blocTest(
      'emits [SignupInProgress] then [SignupSuccess] when [SignupRequested] is called',
      build: () {
        mockUserServices = MockUserServices();
        return SignupBloc(userServices: mockUserServices);
      },
      act: (SignupBloc bloc) {
        return bloc.add(SignupRequested(
            userModel: UserModel(
                fullName: 'valid', email: 'valid', password: 'valid')));
      },
      expect: () => [
            SignupInProgress(),
            SignupSuccess(),
          ]);

  blocTest(
      'emits [SignupFailure] when [SignupRequested] is called and service throws error',
      build: () {
        mockUserServices = MockUserServices();
        return SignupBloc(userServices: mockUserServices);
      },
      act: (SignupBloc bloc) => bloc.add(SignupRequested(
          userModel:
              UserModel(fullName: '123', email: '123', password: '123'))),
      expect: () => [
            SignupInProgress(),
            SignupFailure(),
          ]);

  blocTest(
      'emits [SignupFailure] with all error messages when [SignupErrorDisplayed] is called',
      build: () {
        mockUserServices = MockUserServices();
        return SignupBloc(userServices: mockUserServices);
      },
      act: (SignupBloc bloc) => bloc.add(SignupErrorDetected(
          fullNameErrorMessage: 'error',
          emailErrorMessage: 'error',
          passwordErrorMessage: 'error')),
      expect: () => [
            SignupFailure(
              fullNameErrorMessage: 'error',
              emailErrorMessage: 'error',
              passwordErrorMessage: 'error',
            ),
          ]);
}
