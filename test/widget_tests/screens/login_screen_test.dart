import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_event.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_state.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/navigation_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_body.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_header.dart';
import 'package:mocktail/mocktail.dart';

import '../../cloud_firestore_mock.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class MockUserServices extends Mock implements UserServices {}

class MockUser extends Mock implements User {}

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
  final _loginBloc = LoginBloc(userServices: mockUserServices);
  final _widget = BlocProvider(
    create: (_) => _loginBloc,
    child: MaterialApp(
      routes: {
        "/": (context) => LoginScreen(),
        "/homeScreen": (context) => NavigationScreen(),
      },
      navigatorObservers: [mockObserver],
    ),
  );

  testWidgets('Should render LoginAndSignupHeader, LoginAndsignupBody',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final loginAndSignupHeaderFinder = find.byType(LoginAndSignupHeader);
    final loginAndSignupBodyFinder = find.byType(LoginAndSignupBody);

    expect(loginAndSignupHeaderFinder, findsOneWidget);
    expect(loginAndSignupBodyFinder, findsOneWidget);
  });

  testWidgets('Should navigate to home screen when state is [LoginSuccess]',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    MockUser user = MockUser();
    _loginBloc.emit(LoginSuccess(user: user));
    await tester.pump();

    verify(() => mockObserver.didPush(any(), any()));
  });
}
