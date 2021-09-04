import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'services/new_recipe_services.dart';
import 'blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'screens/new_recipe_screen.dart';
import '../src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import '../src/blocs/login_bloc/login_bloc.dart';
import '../src/blocs/signup_bloc/signup_bloc.dart';
import '../src/screens/forgot_password_screen.dart';
import '../src/screens/home_screen.dart';
import '../src/screens/signup_screen.dart';
import '../src/services/user_services.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';

class App extends StatelessWidget {
  final userServices = UserServices();
  final newRecipeServices = NewRecipeServices();

  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginBloc(userServices: userServices);
    Size designSize = Size(375, 812);
    if (Device.get().isTablet) {
      designSize = Size(768, 1024);
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return ScreenUtilInit(
      designSize: designSize,
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  ForgotPasswordBloc(userServices: userServices)),
          BlocProvider(create: (context) => loginBloc),
          BlocProvider(
              create: (context) => SignupBloc(userServices: userServices)),
          BlocProvider(
              create: (context) =>
                  NewRecipeBloc(newRecipeServices: newRecipeServices)),
        ],
        child: MaterialApp(
          theme: ThemeData(fontFamily: "Nunito-Regular"),
          debugShowCheckedModeBanner: false,
          routes: {
            "/newRecipeScreen": (context) => NewRecipeScreen(),
            "/": (context) => OnboardingScreen(),
            "/forgotPasswordScreen": (context) => ForgotPasswordScreen(),
            "/homeScreen": (context) => HomeScreen(),
            "/loginScreen": (context) => LoginScreen(),
            "/onboardingScreen": (context) => OnboardingScreen(),
            "/signupScreen": (context) => SignupScreen(),
          },
        ),
      ),
    );
  }
}
