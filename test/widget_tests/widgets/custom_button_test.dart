import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  group('signup_screen', () {
    final _signupBloc = SignupBloc(userServices: MockUserServices());
    final Widget _widget = BlocProvider(
      create: (_) => _signupBloc,
      child: MaterialApp(home: SignupScreen()),
    );

    tearDown(() {
      _signupBloc.close();
    });

    testWidgets('Should render the correct button text',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      expect(find.text(SignupScreenText.signupButton), findsOneWidget);
    });
  });

  group('login_screen', () {
    final _loginBloc = LoginBloc(userServices: MockUserServices());
    final Widget _widget = BlocProvider(
      create: (_) => _loginBloc,
      child: MaterialApp(home: LoginScreen()),
    );

    tearDown(() {
      _loginBloc.close();
    });

    testWidgets('Should render the correct button text',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      expect(find.text(LoginScreenText.loginButton), findsOneWidget);
    });
  });
}
