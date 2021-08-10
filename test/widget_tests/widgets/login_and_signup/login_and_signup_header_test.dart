import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockUserServices extends Mock implements UserServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  group('login_screen_tests', () {
    final Widget _widget = BlocProvider(
        create: (_) => LoginBloc(),
        child: MaterialApp(
          home: LoginScreen(),
        ));

    testWidgets('Should render title', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      expect(find.text(LoginScreenText.welcome), findsOneWidget);
    });
  });
}
