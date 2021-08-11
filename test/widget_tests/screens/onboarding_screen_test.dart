import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/onboarding_screen.dart';
import 'package:mobile_app/src/widgets/logo.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() {
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setUp(() => {registerFallbackValue(MyFakeType())});
  final _widget = BlocProvider(
    create: (_) => ForgotPasswordBloc(),
    child: MaterialApp(
      routes: {
        "/": (context) => OnboardingScreen(),
        "/loginScreen": (context) => LoginScreen(),
      },
      navigatorObservers: [mockObserver],
    ),
  );

  testWidgets('Should render a logo', (tester) async {
    await tester.pumpWidget(_widget);
    final logoFinder = find.byType(Logo);
    expect(logoFinder, findsOneWidget);
  });

  group('Onboarding mobile', () {
    testWidgets('Should render Logo with correct title', (tester) async {
      await tester.pumpWidget(_widget);
      final logoFinder = find.byType(Logo);
      expect(logoFinder, findsOneWidget);
    });
    testWidgets('Should navigate when tap on the screen', (tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      await tester.tap(find.byType(GestureDetector));
      verify(() => mockObserver.didPush(any(), any()));
    });
  });

  group('Onboarding tablet', () {
    testWidgets('Should render firstTitle with correct title', (tester) async {
      Device.screenWidth = 900;
      Device.screenHeight = 900;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      final firstTitleFinder = find.text(OnboardingTabletText.firstTitle);
      expect(firstTitleFinder, findsOneWidget);
    });
    testWidgets('Should render secondTitle with correct title', (tester) async {
      Device.screenWidth = 900;
      Device.screenHeight = 900;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      final secondTitleFinder =
          find.text(OnboardingTabletText.secondTitle.replaceFirst(",", "\n"));
      expect(secondTitleFinder, findsOneWidget);
    });

    testWidgets('Find Button "Learn more', (tester) async {
      Device.screenWidth = 900;
      Device.screenHeight = 900;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      final titleApp = find.byType(ElevatedButton);
      final titleButton = find.descendant(
          of: titleApp,
          matching: find.text(OnboardingTabletText.learnMoreButton));
      expect(titleButton, findsOneWidget);
    });
    testWidgets('Find Button "Join Scratch', (tester) async {
      Device.screenWidth = 900;
      Device.screenHeight = 900;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);
      final titleApp = find.byType(ElevatedButton);
      final titleButton = find.descendant(
          of: titleApp, matching: find.text(OnboardingTabletText.joinButton));
      expect(titleButton, findsOneWidget);
    });
  });
}
