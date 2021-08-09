import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_header.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  group('signup_screen_tests', () {
    final Widget _widget = BlocProvider(
        create: (_) => SignupBloc(),
        child: MaterialApp(
          home: SignupScreen(),
        ));

    testWidgets('Should render title with no line break on tablet screen',
        (WidgetTester tester) async {
      Device.width = 1920;
      Device.height = 1920;
      Device.devicePixelRatio = 2;
      await tester.pumpWidget(_widget);

      expect(find.text(SignupScreenText.startFromSratch), findsOneWidget);
    });

    testWidgets('Should render no background on tablet screen',
        (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(_widget);

      final _containerFinder = find.descendant(
          of: find.byType(LoginAndSignupHeader),
          matching: find.byType(Container));
      final _boxDecoration = tester
          .widget<Container>(_containerFinder)
          .decoration as BoxDecoration;
      final _background = _boxDecoration.image;

      expect(_background, isNull);
    });

    testWidgets('Should render the title with linebreak on phone screen',
        (WidgetTester tester) async {
      Device.width = 600;
      Device.height = 600;
      await tester.pumpWidget(_widget);

      final _titleFinder = find.descendant(
          of: find.byType(LoginAndSignupHeader),
          matching: find
              .text(SignupScreenText.startFromSratch.replaceFirst(' ', '\n')));

      expect(_titleFinder, findsOneWidget);
    });

    testWidgets('Should render a small background on phone screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);

      final _containerFinder = find.descendant(
          of: find.byType(LoginAndSignupHeader),
          matching: find.byType(Container));
      final _boxDecoration = tester
          .widget<Container>(_containerFinder)
          .decoration as BoxDecoration;
      final _background = _boxDecoration.image as DecorationImage;

      expect(_background.image,
          AssetImage('assets/images/login-signup-background.jpeg'));
    });
  });
}
