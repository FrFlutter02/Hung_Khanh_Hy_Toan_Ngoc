import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/widgets/login_and_signup/password_text_form_field.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();

  final widget = MaterialApp(
    home: BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: LoginScreen(),
      ),
    ),
    navigatorObservers: [mockObserver],
  );

  testWidgets("Should render password textformfield Test",
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    var passwordTextFormField = find.byType(PasswordTextField);
    expect(passwordTextFormField, findsOneWidget);
    await tester.enterText(passwordTextFormField, 'password123');
    expect(find.text('password123'), findsOneWidget);
  });
}
