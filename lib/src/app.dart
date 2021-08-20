import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../src/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import '../src/blocs/login_bloc/login_bloc.dart';
import '../src/blocs/signup_bloc/signup_bloc.dart';
import '../src/screens/forgot_password_screen.dart';
import '../src/screens/home_screen.dart';
import '../src/screens/signup_screen.dart';
import '../src/services/user_services.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/user_profile_screen/my_profile_screen.dart';
import 'screens/user_profile_screen/view_profile_screen.dart';

class App extends StatelessWidget {
  final userServices = UserServices();
  late Size designSize;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    if (Device.get().isPhone) {
      designSize = Size(375, 812);
    } else {
      designSize = Size(770, 1024);
    }
    return ScreenUtilInit(
        designSize: designSize,
        builder: () => MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) =>
                        ForgotPasswordBloc(userServices: userServices)),
                BlocProvider(
                    create: (context) => LoginBloc(userServices: userServices)),
                BlocProvider(
                    create: (context) =>
                        SignupBloc(userServices: userServices)),
              ],
              child: MaterialApp(
                theme: ThemeData(fontFamily: "Nunito-Regular"),
                debugShowCheckedModeBanner: false,
                initialRoute: "/myProfile",
                routes: {
                  "/": (context) => OnboardingScreen(),
                  "/forgotPasswordScreen": (context) => ForgotPasswordScreen(),
                  "/homeScreen": (context) => HomeScreen(),
                  "/loginScreen": (context) => LoginScreen(),
                  "/onboardingScreen": (context) => OnboardingScreen(),
                  "/signupScreen": (context) => SignupScreen(),
                  "/myProfile": (context) => MyProfileScreen(),
                  "/viewProfile": (context) => ViewProfileScreen()
                },
              ),
            ));
  }
}
