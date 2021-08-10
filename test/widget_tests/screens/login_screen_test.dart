import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_state.dart';
import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_body.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_header.dart';

import '../../cloud_firestore_mock.dart';

// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// class MockUserService extends Mock implements UserServices {
//   final MockFirebaseAuth? auth;

//   MockUserService({this.auth});
// }

main() {
  setupCloudFirestoreMocks();
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });
  final widget = MaterialApp(
    home: BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        body: LoginScreen(),
      ),
    ),
  );
  LoginBloc loginBloc = LoginBloc();
  testWidgets(
      'Should show a CircularProgressIndicator when bloc state is [LoginInProgress]',
      (tester) async {
    await tester.pumpWidget(widget);
    loginBloc.emit(LoginInProgress());

    expect(find.text('Login'), findsOneWidget);
    print('button tapped');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    final indicatorFinder = find.byType(CircularProgressIndicator);
    await tester.pumpAndSettle();
    expect(indicatorFinder, findsNothing);
  });

  testWidgets('Should show login and signup header, body', (tester) async {
    await tester.pumpWidget(widget);
    final headerFinder = find.byType(LoginAndSignupHeader);
    final bodyFinder = find.byType(LoginAndSignupBody);
    expect(headerFinder, findsOneWidget);
    expect(bodyFinder, findsOneWidget);
  });
}
