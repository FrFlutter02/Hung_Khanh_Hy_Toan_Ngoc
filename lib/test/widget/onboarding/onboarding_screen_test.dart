import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/onboarding_screen.dart';

void main() {
  var onboardingScreen = MaterialApp(home: OnboardingScreen());
  group(' tablet onboarding screen', () {
    testWidgets('onboarding should display correct title',
        (WidgetTester tester) async {
      await tester.pumpWidget(onboardingScreen);
      final titleFinder = find.text(OnboardingTabletText.firstTitle);
      expect(titleFinder, findsOneWidget);
    });
  });
}
