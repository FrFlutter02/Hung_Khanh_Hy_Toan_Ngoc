import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_event.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_state.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';

import '../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {}

void main() {
  UserServices userServices = MockUserServices();
  SignupBloc signupBloc = SignupBloc(userServices: userServices);

  setUpAll(() async {
    setupCloudFirestoreMocks();
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  tearDown(() {
    signupBloc.close();
  });

  blocTest('emits [] when no events is called',
      build: () {
        userServices = MockUserServices();
        return SignupBloc(userServices: userServices);
      },
      expect: () => []);

  blocTest(
      'emits [SignupInProgress] then [SignupSuccess] when [SignupRequested] is called',
      build: () {
        userServices = MockUserServices();
        return SignupBloc(userServices: userServices);
      },
      act: (SignupBloc bloc) => bloc.add(SignupRequested(
          userModel:
              UserModel(fullName: 'c', email: 'c@gmail.com', password: '789'))),
      expect: () => [
            SignupInProgress(),
            SignupSuccess(),
          ]);

  blocTest(
      'emits [SignupFailure] when [SignupRequested] is called and service throws error',
      build: () {
        userServices = MockUserServices();
        when(userServices.signUp('fullName', 'email', 'password'))
            .thenThrow(Exception());
        return SignupBloc(userServices: userServices);
      },
      act: (SignupBloc bloc) => bloc.add(
            SignupRequested(userModel: UserModel()),
          ),
      expect: () => [
            SignupInProgress(),
            SignupFailure(failErrorMessage: Exception().toString()),
          ]);
}
