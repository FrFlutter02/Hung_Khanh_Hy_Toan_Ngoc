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
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(widget);
      await tester.pump();
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

    testWidgets("Should render email textformfield Test",
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      var emailTextFormField = find.byType(EmailTextFormField);
      expect(emailTextFormField, findsOneWidget);
      await tester.enterText(emailTextFormField, 'email@gmail.com');
      expect(find.text('email@gmail.com'), findsOneWidget);
    });
    testWidgets("Should render password textformfield Test",
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      PasswordTextFormField passwordTextFormField =
          tester.widget(find.byType(PasswordTextFormField));
      expect(passwordTextFormField, findsOneWidget);
      await tester.enterText(find.byType(PasswordTextFormField), 'password123');
      expect(find.text('password123'), findsOneWidget);
      expect(
          passwordTextFormField.errorText, equals('Email must not be empty'));
    });
    testWidgets("Should render button", (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(widget);
      expect(find.text('Login'), findsOneWidget);
      print('button tapped');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
    });

    testWidgets('validate email inline error message',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      final loginButton = find.text('Login');
      final emailErrorFinder = find.text('Email must not be empty');

      await tester.tap(loginButton);
      print('button tapped');
      await tester.pump(const Duration(milliseconds: 1000)); // add delay
      expect(emailErrorFinder, findsOneWidget);
      print('validated email inline error');
    });

    testWidgets('Counter increments smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      // verify(() => mockObserver.didPush(any(), any())).called(1);
    });
  });
}
