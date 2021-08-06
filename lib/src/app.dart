import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/screens/forgot_password_screen.dart';
import '../src/screens/login_screen.dart';
import '../src/screens/onboarding_screen.dart';
import '../src/screens/home_screen.dart';
import '../src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ForgotPasswordBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Nunito-Regular"),
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => ForgotPasswordScreen(),
          "/forgotPasswordScreen": (context) => ForgotPasswordScreen(),
          "/homeScreen": (context) => HomeScreen(),
          "/loginScreen": (context) => LoginScreen(),
          "/onboardingScreen": (context) => OnboardingScreen(),
        },
      ),
    );
  }
}
