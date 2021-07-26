import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';

import '../src/screens/login_screen.dart';
import '../src/screens/onboarding_screen.dart';
import '../src/screens/signup_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignupBloc()),
        ],
        child: MaterialApp(
          routes: {
            "/": (context) => SignupScreen(),
            "/loginScreen": (context) => LoginScreen(),
            "/signupScreen": (context) => OnboardingScreen(),
          },
        ));
  }
}
