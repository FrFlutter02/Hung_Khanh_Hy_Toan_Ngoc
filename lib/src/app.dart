import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'blocs/keyword_search_bloc/keyword_search_bloc.dart';
import 'blocs/login_bloc/login_bloc.dart';
import 'blocs/new_recipe_bloc/new_recipe_bloc.dart';
import 'blocs/signup_bloc/signup_bloc.dart';
import 'blocs/post_bloc/post_bloc.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/navigation_screen.dart';
import 'screens/new_recipe_screen.dart';
import 'screens/signup_screen.dart';
import 'services/create_recipe_services.dart';
import 'services/search_services.dart';
import 'services/user_services.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/recipe_feed_screen.dart';
import 'screens/search_screen.dart';
import 'services/post_service.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userServices = UserServices();
    final postServices = PostServices();
    final searchServices = SearchServices();
    final createRecipeServices = CreateRecipeServices();

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
        BlocProvider(
            create: (context) =>
                KeywordSearchBloc(searchServices: searchServices)),
        BlocProvider(
            create: (context) => PostBloc(
                postServices: postServices, userServices: userServices)),
        BlocProvider(
            create: (context) =>
                NewRecipeBloc(newRecipeServices: createRecipeServices)),
      ],
      child: ScreenUtilInit(
        designSize: designSize,
        builder: () => MaterialApp(
          theme: ThemeData(fontFamily: "Nunito-Regular"),
          debugShowCheckedModeBanner: false,
          routes: {
            "/": (context) => OnboardingScreen(),
            "/forgotPasswordScreen": (context) => ForgotPasswordScreen(),
            "/navigationScreen": (context) => NavigationScreen(),
            "/loginScreen": (context) => LoginScreen(),
            "/signupScreen": (context) => SignupScreen(),
            "/recipeFeedScreen": (context) => RecipeFeedScreen(),
            "/searchScreen": (context) => SearchScreen(),
            "/newRecipeScreen": (context) => NewRecipeScreen(),
          },
        ),
      ),
    );
  }
}
