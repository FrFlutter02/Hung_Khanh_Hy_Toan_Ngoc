import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/custom_button.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {}

void main() {
  setupCloudFirestoreMocks();
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  final _signupBloc = SignupBloc(userServices: MockUserServices());
  final Widget _widget = BlocProvider(
    create: (_) => SignupBloc(),
    child: MaterialApp(
      routes: {
        "/": (context) => SignupScreen(),
        "/loginScreen": (context) => LoginScreen(),
      },
    ),
  );

  testWidgets('Should render the correct button text',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    expect(find.text(SignupScreenText.signupButton), findsOneWidget);
  });

  testWidgets('Should be clickable when this is not loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final _customButtonFinder = find.byType(CustomButton);
    final _customButtonWidgetEnabled =
        tester.widget<CustomButton>(_customButtonFinder);
    expect(_customButtonWidgetEnabled, isTrue);
  });

  testWidgets('Should not be clickable when this is loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final _customButtonFinder = find.byType(CustomButton);
    _signupBloc.emit(SignupInProgress());
    await tester.pumpAndSettle();
    final _customButtonWidgetEnabled =
        tester.widget<CustomButton>(_customButtonFinder);
    expect(_customButtonWidgetEnabled, isFalse);
  });
}
