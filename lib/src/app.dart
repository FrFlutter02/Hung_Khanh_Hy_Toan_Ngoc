import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/signup_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return
        // MultiBlocProvider(
        //     providers: [
        //     ],
        //     child:
        MaterialApp(
      theme: ThemeData(fontFamily: 'Nunito-Regular'),
      routes: {
        "/": (context) => SignupScreen(),
        "/loginScreen": (context) => LoginScreen(),
        "/signupScreen": (context) => OnboardingScreen(),
      },
    );
    // );
  }
}
