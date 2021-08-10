import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/widgets/login_and_signup/email_text_form_field.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_body.dart';
import 'package:mobile_app/src/widgets/login_and_signup/password_text_form_field.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyTypeFake extends Fake implements Route {}

void main() {
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();

  group('widget login body', () {
    final widget = MaterialApp(
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: Scaffold(
          body: LoginScreen(),
        ),
      ),
      navigatorObservers: [mockObserver],
    );

    testWidgets('login screen test', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      expect(find.text('Please login to continue.'), findsOneWidget);
      expect(find.text('Email address'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot password?'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('New to Scratch?'), findsOneWidget);
      expect(find.text('Create Account Here'), findsOneWidget);
    });

    testWidgets('Should render text a form Login', (tester) async {
      await tester.pumpWidget(widget);
      final formLogin = find.byType(LoginAndSignupBody);
      expect(formLogin, findsOneWidget);
    });

    testWidgets('Should render image background tablet',
        (WidgetTester tester) async {
      final Image imageWidget = Image.asset(
        'assets/images/login-signup-background.jpeg',
      );
      assert(imageWidget.image is AssetImage);
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.keyName, 'assets/images/login-signup-background.jpeg');
    });
  });
}
