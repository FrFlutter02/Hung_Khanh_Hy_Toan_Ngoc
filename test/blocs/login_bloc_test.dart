import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_state.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_event.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../cloud_firestore_mock.dart';

class MockLoginService extends Mock implements UserServices {}

class MockLoginEvent extends LoginEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

main() {
  Firebase.initializeApp();
  UserServices userServices;
  LoginBloc? loginBloc;

  setUp(() async {
    userServices = MockLoginService();
    loginBloc = LoginBloc(userServices: userServices);
  });

  tearDown(() {
    loginBloc?.close();
  });

  test('close does not emit new states', () {
    expectLater(
      loginBloc,
      emitsInOrder([LoginInitial(), emitsDone]),
    );
    loginBloc?.close();
  });
  blocTest('emits [] when no event is added',
      build: () {
        userServices = MockLoginService();
        return LoginBloc(userServices: userServices);
      },
      expect: () => []);

  blocTest(
    'emits [LoginFailure] when invalid event is called',
    build: () {
      userServices = MockLoginService();
      return LoginBloc(userServices: userServices);
    },
    act: (LoginBloc bloc) => bloc.add(MockLoginEvent()),
    expect: () => [LoginFailure()],
  );

  blocTest(
    'emits [LoginInProgress] then [LoginSuccess] when [LoginRequested] is called',
    build: () {
      userServices = MockLoginService();
      return LoginBloc(userServices: userServices);
    },
    act: (LoginBloc bloc) => bloc.add(LoginRequested()),
    expect: () => [
      LoginInProgress(),
      LoginSuccess(),
    ],
  );

  blocTest(
    'emits [LoginFailure] when [LoginRequested] is called and service throws error.',
    build: () {
      userServices = MockLoginService();
      when(userServices.logIn("email", "password")).thenThrow(Exception());
      return LoginBloc(userServices: userServices);
    },
    act: (LoginBloc bloc) => bloc.add(LoginRequested()),
    expect: () => [
      LoginInProgress(),
      LoginFailure(
          emailErrorMessage: Exception().toString(),
          passwordErrorMessage: Exception().toString()),
    ],
  );
}
