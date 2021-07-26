import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/scratch_form_bloc/scratch_form_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/signup_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ScratchFormBloc()),
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
