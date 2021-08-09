import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_state.dart';
import '../../../src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/onboarding_screen.dart';
import 'package:mobile_app/src/widgets/logo.dart';

import '../../cloud_firestore_mock.dart';

void main() {
  setupCloudFirestoreMocks();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });
  final widget = MaterialApp(
    home: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ForgotPasswordBloc(),
      )
    ], child: OnboardingScreen()),
  );
  group('onboarrding Tablet', () {
    testWidgets('onboarrding show title', (tester) async {
      await tester.pumpWidget(widget);
      final firstTitleFinder = find.text('scratch');
      expect(firstTitleFinder, findsOneWidget);
    });
  });
}
