import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_state.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/widgets/custom_button.dart';
import 'package:mobile_app/src/widgets/login_and_signup/email_text_form_field.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyTypeFake extends Fake implements Route {}

main() {
  NavigatorObserver mockObserver;
  mockObserver = MockNavigatorObserver();
  setupCloudFirestoreMocks();
  setUpAll(() async {
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

  testWidgets("Should render email textformfield Test",
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    var emailTextField = find.descendant(
        of: find.byType(EmailTextField), matching: find.byType(TextField));
    loginBloc.emit(
        LoginFailure(emailErrorMessage: AppText.emailMustNotBeEmptyErrorText));
    await tester.pump();
    var emailError =
        (tester.widget<TextField>(emailTextField).decoration!.errorText);

    expect(emailError, AppText.emailMustNotBeEmptyErrorText);
  });
}
