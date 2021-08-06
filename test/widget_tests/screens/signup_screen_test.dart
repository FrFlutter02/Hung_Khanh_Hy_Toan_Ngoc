import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_event.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_state.dart';
import 'package:mobile_app/src/screens/home_screen.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';

import '../../cloud_firestore_mock.dart';

class MockSignupBloc extends MockBloc<SignupEvent, SignupState>
    implements SignupBloc {}

class MockUserServices extends Mock implements UserServices {}

void main() {
  setupCloudFirestoreMocks();
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });

  final userServices = MockUserServices();
  final signupBloc = SignupBloc(userServices: userServices);
  final _widget = BlocProvider(
    create: (context) => SignupBloc(),
    child: MaterialApp(
      home: SignupScreen(),
    ),
  );

  testWidgets('Should navigate to home screen when state is [SignupSuccess]',
      (WidgetTester tester) async {
    await tester.pumpWidget(_widget);
    signupBloc.emit(SignupSuccess());
    await tester.pump();
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
