import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_state.dart';
import 'package:mobile_app/src/screens/forgot_password_screen.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/logo.dart';
import 'package:mocktail/mocktail.dart';

import '../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {}

class MockNavigationObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
    registerFallbackValue(FakeRoute());
  });
  final _forgotBloc = ForgotPasswordBloc();
  final mockObserver = MockNavigationObserver();
  final _widget = BlocProvider(
    create: (_) => _forgotBloc,
    child: MaterialApp(
      routes: {
        "/": (context) => ForgotPasswordScreen(),
        "/loginScreen": (context) => LoginScreen(),
      },
      navigatorObservers: [mockObserver],
    ),
  );
  group('Forgot password mobile', () {
    testWidgets('Should render Logo', (tester) async {
      await tester.pumpWidget(_widget);
      final logoFinder = find.byType(Logo);
      expect(logoFinder, findsOneWidget);
    });

    testWidgets('Should render forgot password title with correct title',
        (tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      final tabletLabelFinder = find.text("Reset password");
      expect(tabletLabelFinder, findsOneWidget);
    });
  });
  group('Forgot password tablet', () {
    testWidgets('Should render Logo', (tester) async {
      Device.devicePixelRatio = 1;
      Device.screenWidth = 900;
      Device.screenHeight = 900;
      await tester.pumpWidget(_widget);
      final logoFinder = find.byType(Logo);
      expect(logoFinder, findsOneWidget);
    });

    testWidgets('Should render tabletLabel with correct label', (tester) async {
      Device.devicePixelRatio = 1;
      Device.screenWidth = 900;
      Device.screenHeight = 900;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      final tabletLabelFinder = find.text("Start from Scratch");
      expect(tabletLabelFinder, findsOneWidget);
    });
    testWidgets('Should render forgot passwordtitle with correct title',
        (tester) async {
      Device.devicePixelRatio = 1;
      Device.screenWidth = 900;
      Device.screenHeight = 900;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      final tablettitleFinder =
          find.text("Reset password".replaceFirst(' ', '\n'));
      expect(tablettitleFinder, findsOneWidget);
    });
    testWidgets('Should render form', (tester) async {
      Device.devicePixelRatio = 1;
      Device.screenWidth = 900;
      Device.screenHeight = 900;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      final fromFinder = find.byType(Form);
      expect(fromFinder, findsOneWidget);
    });
    testWidgets(
        'Should navigate to login screen when state is [ForgotPasswordSuccess]',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      _forgotBloc.emit(ForgotPasswordSuccess());
      await tester.pump();
      verify(() => mockObserver.didPush(any(), any()));
    });
  });
}
