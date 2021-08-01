import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/screens/forgot_password_screen.dart';
import '../../src/services/user_services.dart';

import '../src/screens/login_screen.dart';
import '../src/screens/onboarding_screen.dart';
import '../src/blocs/auth_bloc/auth_bloc.dart';
import '../src/blocs/login_bloc/login_bloc.dart';
import '../src/blocs/signup_bloc/signup_bloc.dart';
import '../src/screens/home_screen.dart';

class App extends StatelessWidget {
  final UserServices userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(userServices: userServices)),
        BlocProvider(
            create: (context) => LoginBloc(userServices: userServices)),
        BlocProvider(
            create: (context) => SignupBloc(userServices: userServices)),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Nunito-Regular"),
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => ForgotPassword(),
          // "/forgotPasswordScreen": (context) => ForgotPassword(),
          "/homeScreen": (context) => HomeScreen(),
          "/loginScreen": (context) => LoginScreen(),
          "/onboardingScreen": (context) => OnboardingScreen(),
        },
      ),
    );
  }
}
