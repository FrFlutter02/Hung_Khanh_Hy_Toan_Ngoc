import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/widgets/login_and_signup/password_text_field.dart';

import '../../../cloud_firestore_mock.dart';

main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final LoginBloc loginBloc = LoginBloc();
  final widget = MaterialApp(
    home: BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
        body: LoginScreen(),
      ),
    ),
  );

  testWidgets("Should render password textformfield Test",
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    var passwordTextField = find.descendant(
        of: find.byType(PasswordTextField), matching: find.byType(TextField));
    loginBloc.emit(LoginFailure(
        passwordErrorMessage: AppText.passwordMustNotBeEmptyErrorText));
    await tester.pump();
    var passwordError =
        (tester.widget<TextField>(passwordTextField).decoration!.errorText);

    expect(passwordError, AppText.passwordMustNotBeEmptyErrorText);
  });
}
