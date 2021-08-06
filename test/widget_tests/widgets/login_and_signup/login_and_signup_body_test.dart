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
  setupCloudFirestoreMocks();
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  final Widget _widget = BlocProvider(
    create: (_) => SignupBloc(),
    child: MaterialApp(
      routes: {
        "/": (context) => SignupScreen(),
        "/loginScreen": (context) => LoginScreen(),
      },
    ),
  );

  testWidgets('Should render the correct title text',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    expect(find.text(SignupScreenText.createAccountToContinue), findsOneWidget);
  });

  testWidgets('Should render the correct bottom title text',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    expect(find.text(SignupScreenText.alreadyHaveAnAccount), findsOneWidget);
  });

  testWidgets('Should render the correct bottom link text',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    expect(find.text(SignupScreenText.loginHere), findsOneWidget);
  });

  testWidgets('Should navigate to the correct route',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final _signupCustomButtonFinder = find.byKey(Key('bottomLink'));
    expect(_signupCustomButtonFinder, findsOneWidget);
    await tester.tap(_signupCustomButtonFinder);
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
