import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_state.dart';
import '../../../src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/onboarding_screen.dart';
import 'package:mobile_app/src/widgets/logo.dart';

import '../../cloud_firestore_mock.dart';

void main() async {
  setupCloudFirestoreMocks();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });
  final widget = MaterialApp(
    home: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ForgotPasswordBloc(),
      )
    ], child: OnboardingScreen()),
  );
  group('onboarrding Tablet', () {
    testWidgets('onboarrding show title', (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpWidget(widget);
      final firstTitleFinder =
          find.text('Join over 50 millions people sharing recipes everday');
      final secondTitleFinder = find.text(
          'Never run out ideas again. Try new foods, ingredients, cooking style, and more');
      ForgotPasswordBloc().emit(ForgotPasswordInitial());
      await tester.pump();
      expect(firstTitleFinder, findsOneWidget);
      expect(secondTitleFinder, findsOneWidget);
    });
    testWidgets('onboarrding show text button', (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpWidget(widget);
      final joinButton = find.text('Join Scratch');
      final learnMoreButton = find.text('Learn More');
      await tester.pump();
      expect(joinButton, findsOneWidget);
      expect(learnMoreButton, findsOneWidget);
    });
    testWidgets('Should render logo with title', (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpWidget(widget);
      final logoFinder = find.byType(Logo);
      final albumTitleFinder =
          find.descendant(of: logoFinder, matching: find.text('Join Scratch'));

      await tester.pump();
      expect(albumTitleFinder, findsOneWidget);
    });
    testWidgets('Should button click', (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpWidget(widget);
      await tester.tap(find.byType(ElevatedButton));
      final navigateLoginPage = find.byType(LoginScreen);
      await tester.pump();

      // Expect to find the item on screen.
      expect(navigateLoginPage, findsOneWidget);
    });
  });
  group('onboarrding Mobile', () {
    testWidgets('Should render logo with title', (tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1000, 1500);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await tester.pumpWidget(widget);
      final logoFinder = find.byType(Logo);
      final albumTitleFinder =
          find.descendant(of: logoFinder, matching: find.text('Join Scratch'));
      ForgotPasswordBloc().emit(ForgotPasswordInitial());
      await tester.pump();
      expect(albumTitleFinder, findsOneWidget);
    });
  });
}
