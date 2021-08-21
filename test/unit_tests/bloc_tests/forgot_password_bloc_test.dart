import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_event.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_state.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {
  @override
  Future<UserCredential?> signUp(UserModel userModel) async {
    if (userModel.email != 'valid') {
      throw Exception();
    }
  }
}

void main() {
  ForgotPasswordBloc? forgotBloc;
  MockUserServices mockUserServices;
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  setUp(() async {
    forgotBloc = ForgotPasswordBloc();
  });

  tearDown(() {
    forgotBloc?.close();
  });

  blocTest('emits [] when no events is called',
      build: () {
        return ForgotPasswordBloc();
      },
      expect: () => []);

  blocTest(
      'emits [ForgotPasswordFailure] with empty error when [ForgotPasswordRequested] has invalid email',
      build: () {
        mockUserServices = MockUserServices();
        return ForgotPasswordBloc(userServices: mockUserServices);
      },
      act: (ForgotPasswordBloc bloc) {
        return bloc.add(ForgotPasswordRequested(''));
      },
      expect: () => [ForgotPasswordFailure()]);

  blocTest(
      'emits [ForgotPasswordFailure] with invalid format error when [ForgotPasswordRequested] has invalid email',
      build: () {
        return ForgotPasswordBloc();
      },
      act: (ForgotPasswordBloc bloc) =>
          bloc.add(ForgotPasswordRequested('aaaa')),
      expect: () => [ForgotPasswordFailure()]);
}
