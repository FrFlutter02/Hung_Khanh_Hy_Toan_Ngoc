import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_header.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  final _userServices = MockUserServices();
  final Widget _widget = BlocProvider(
    create: (_) => SignupBloc(userServices: _userServices),
    child: MaterialApp(
        home: LoginAndSignupHeader(
      isTabletScreen: false,
      loginAndSignupHeaderTitle: SignupScreenText.startFromSratch,
    )),
  );

  testWidgets('Should render the correct title at SignupScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    final _titleFinder = find.text(SignupScreenText.startFromSratch);
    expect(_titleFinder, findsOneWidget);
  });

  // testWidgets('Should render no background on tablet screen',
  //     (WidgetTester tester) async {
  //   tester.binding.window.physicalSizeTestValue = Size(1500, 1500);
  //   addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  //   tester.binding.window.devicePixelRatioTestValue = 1;
  //   await tester.pumpWidget(_widget);
  //   final _backgroundFinder = find.byType(DecorationImage);
  //   expect(_backgroundFinder, findsNothing);
  // });

  // testWidgets('Should render a small background on phone screen',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(_widget);
  //   final _backgroundFinder = find.byType(DecorationImage);
  //   expect(_backgroundFinder, findsOneWidget);
  // });
}
