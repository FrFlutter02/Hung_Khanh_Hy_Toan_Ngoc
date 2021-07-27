import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/signup_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // MultiBlocProvider(
        //     providers: [
        //     ],
        //     child:
        MaterialApp(
      routes: {
        "/": (context) => SignupScreen(),
        "/loginScreen": (context) => LoginScreen(),
        "/signupScreen": (context) => OnboardingScreen(),
      },
    );
    // );
  }
}
