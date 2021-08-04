import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:mobile_app/src/blocs/forgot_password_bloc/forgot_password_state.dart';

import 'package:mobile_app/src/screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  final widget = MaterialApp(
    home: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ForgotPasswordBloc(),
      )
    ], child: OnboardingScreen()),
  );
  testWidgets('onboarrding with correct second title', (tester) async {
    await tester.pumpWidget(widget);
    final titleFinder = find.text(
        'Never run out ideas again. Try new foods, ingredients, cooking style, and more');
    ForgotPasswordBloc().emit(ForgotPasswordInitial());
    await tester.pump();
    expect(titleFinder, findsOneWidget);
  });
}
