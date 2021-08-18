import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import '../src/blocs/login_bloc/login_bloc.dart';
import '../src/blocs/signup_bloc/signup_bloc.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/signup_screen.dart';
import 'services/user_services.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/recipe_feed_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userServices = UserServices();

    Size designSize = Size(375, 812);

    if (Device.get().isTablet) {
      designSize = Size(768, 1024);
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ForgotPasswordBloc(userServices: userServices)),
        BlocProvider(
            create: (context) => LoginBloc(userServices: userServices)),
        BlocProvider(
            create: (context) => SignupBloc(userServices: userServices)),
      ],
      child: ScreenUtilInit(
        designSize: designSize,
        builder: () => MaterialApp(
          theme: ThemeData(fontFamily: "Nunito-Regular"),
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) => HomeScreen(),
            // "/": (context) => RecipeFeedScreen(),
            // "/": (context) => OnboardingScreen(),
            "/forgotPasswordScreen": (context) => ForgotPasswordScreen(),
            "/homeScreen": (context) => HomeScreen(),
            "/loginScreen": (context) => LoginScreen(),
            "/onboardingScreen": (context) => OnboardingScreen(),
            "/signupScreen": (context) => SignupScreen(),
            "/recipeFeedScreen": (context) => RecipeFeedScreen(),
          },
        ),
      ),
    );
  }
}
