import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_body.dart';

void main() {
  final _widget = Container();

  testWidgets('Should render correct label', (WidgetTester tester) async {
    await tester.pumpWidget(_widget);

    final _titleFinder = find.descendant(
        of: find.byType(LoginAndSignupBody),
        matching: find.text(SignupScreenText.emailNameLabel));

    expect(_titleFinder, findsOneWidget);
  });

  // testWidgets('Should render empty error message when email field is empty', callback)

  // testWidgets('Should render no error message when email field is not empty', callback)
}
