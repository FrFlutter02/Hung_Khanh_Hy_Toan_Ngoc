import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_event.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/home_screen.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/login_and_signup/email_text_field.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_body.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_header.dart';
import 'package:mocktail/mocktail.dart';

import '../../cloud_firestore_mock.dart';

class MockSignupBloc extends MockBloc<SignupEvent, SignupState>
    implements SignupBloc {}

class MockUserServices extends Mock implements UserServices {}

class MockNavigationObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
    registerFallbackValue(FakeRoute());
  });

  final mockObserver = MockNavigationObserver();
  final mockUserServices = MockUserServices();
  final _signupBloc = SignupBloc(userServices: mockUserServices);
  final _widget = BlocProvider(
    create: (_) => _signupBloc,
    child: MaterialApp(
      routes: {
        "/": (context) => SignupScreen(),
        "/homeScreen": (context) => HomeScreen(),
      },
      navigatorObservers: [mockObserver],
    ),
  );
  testWidgets(
      'Should render EmailTextField correct errorText when state is [SignupFailure]',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final emailTextField = find.byType(EmailTextField);

    _signupBloc
        .emit(SignupFailure(emailErrorMessage: AppText.emailInvalidErrorText));
    await tester.pump();
    var emailError = (tester.widget<EmailTextField>(emailTextField).errorText);
    print(emailError);
    expect(emailError, AppText.emailInvalidErrorText);

    _signupBloc.emit(
        SignupFailure(emailErrorMessage: AppText.emailAlreadyExistsErrorText));
    await tester.pump();
    var emailError1 = (tester.widget<EmailTextField>(emailTextField).errorText);
    print(emailError1);
    expect(emailError1, AppText.emailAlreadyExistsErrorText);

    _signupBloc.emit(
        SignupFailure(emailErrorMessage: AppText.emailMustNotBeEmptyErrorText));
    await tester.pump();
    var emailError2 = (tester.widget<EmailTextField>(emailTextField).errorText);
    print(emailError2);
    expect(emailError2, AppText.emailMustNotBeEmptyErrorText);
    _signupBloc.emit(SignupFailure(emailErrorMessage: ''));
    await tester.pump();
    var emailError3 = (tester.widget<EmailTextField>(emailTextField).errorText);
    print(emailError3);
    expect(emailError3, '');
  });
  testWidgets('Should render LoginAndSignupHeader, LoginAndsignupBody',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final loginAndSignupHeaderFinder = find.byType(LoginAndSignupHeader);
    final loginAndSignupBodyFinder = find.byType(LoginAndSignupBody);

    expect(loginAndSignupHeaderFinder, findsOneWidget);
    expect(loginAndSignupBodyFinder, findsOneWidget);
  });

  testWidgets('Should navigate to home screen when state is [SignupSuccess]',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    _signupBloc.emit(SignupSuccess());
    await tester.pump();

    verify(() => mockObserver.didPush(any(), any()));
  });
}
