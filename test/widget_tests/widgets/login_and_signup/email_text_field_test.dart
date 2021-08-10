import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/widgets/login_and_signup/email_text_field.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    TestWidgetsFlutterBinding.ensureInitialized();
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

  testWidgets("Should render error messages when email is invalid",
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    var emailTextField = find.descendant(
        of: find.byType(EmailTextField), matching: find.byType(TextField));
    var emailError =
        (tester.widget<TextField>(emailTextField).decoration!.errorText);

    loginBloc.emit(
        LoginFailure(emailErrorMessage: AppText.emailMustNotBeEmptyErrorText));
    await tester.pump();
    expect(emailError, AppText.emailMustNotBeEmptyErrorText);
  });
}
