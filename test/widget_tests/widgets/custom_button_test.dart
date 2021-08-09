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
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  group('signup_screen_tests', () {
    final _signupBloc = SignupBloc(userServices: MockUserServices());
    final Widget _widget = BlocProvider(
      create: (_) => _signupBloc,
      child: MaterialApp(
        routes: {
          "/": (context) => SignupScreen(),
          "/loginScreen": (context) => LoginScreen(),
        },
      ),
    );

    tearDown(() {
      _signupBloc.close();
    });

    testWidgets('Should render the correct button text',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      expect(find.text(SignupScreenText.signupButton), findsOneWidget);
    });

    testWidgets('Should be clickable when not loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      final _customButtonFinder = find.descendant(
          of: find.byType(CustomButton), matching: find.byType(ElevatedButton));
      final _customButtonWidgetEnabled =
          tester.widget<ElevatedButton>(_customButtonFinder).enabled;
      expect(_customButtonWidgetEnabled, isTrue);
    });

    testWidgets('Should not be clickable when loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      final _customButtonFinder = find.descendant(
          of: find.byType(CustomButton), matching: find.byType(ElevatedButton));

      _signupBloc.emit(SignupInProgress());
      await tester.pump();

      final _customButtonWidgetEnabled =
          tester.widget<ElevatedButton>(_customButtonFinder).enabled;
      expect(_customButtonWidgetEnabled, isFalse);
    });
  });
}
