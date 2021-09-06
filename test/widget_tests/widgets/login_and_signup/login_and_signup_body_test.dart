import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';

import '../../../cloud_firestore_mock.dart';

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  group('signup_screen_tests', () {
    final Widget _widget = BlocProvider(
      create: (_) => SignupBloc(),
      child: MaterialApp(
        routes: {
          "/": (context) => SignupScreen(),
          "/loginScreen": (context) => LoginScreen(),
        },
      ),
    );

    testWidgets('Should render the correct text', (WidgetTester tester) async {
      final _titleFinder = find.text(SignupScreenText.createAccountToContinue);
      final _bottomTitleFinder =
          find.text(SignupScreenText.alreadyHaveAnAccount);
      final _bottomLinkFinder = find.text(SignupScreenText.loginHere);

      await tester.pumpWidget(_widget);

      expect(_titleFinder, findsOneWidget);
      expect(_bottomTitleFinder, findsOneWidget);
      expect(_bottomLinkFinder, findsOneWidget);
    });
  });
}
