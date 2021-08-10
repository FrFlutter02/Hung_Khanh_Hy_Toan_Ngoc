import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_bloc/login_event.dart';
import '../blocs/login_bloc/login_state.dart';
import '../widgets/login_and_signup/email_text_form_field.dart';
import '../widgets/login_and_signup/login_and_signup_body.dart';
import '../widgets/login_and_signup/login_and_signup_header.dart';
import '../widgets/login_and_signup/password_text_form_field.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isTabletScreen = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    if (Device.get().isTablet) {
      isTabletScreen = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushNamed('/homeScreen');
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: isTabletScreen
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/login-signup-background.jpeg'),
                        )
                      : null,
                ),
              ),
              Container(
                height: Device.screenHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.white.withOpacity(0.2),
                      AppColor.white,
                    ],
                    stops: [0.0, 0.9],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginAndSignupHeader(
                      isTabletScreen: isTabletScreen,
                      loginAndSignupHeaderTitle: LoginScreenText.welcome,
                    ),
                    LoginAndSignupBody(
                      loginBloc: context.read<LoginBloc>(),
                      titleText: LoginScreenText.pleaseLogin,
                      isTabletScreen: isTabletScreen,
                      textFormFieldList: [
                        EmailTextField(
                            errorText: state is LoginFailure
                                ? state.emailErrorMessage
                                : '',
                            label: LoginScreenText.emailLabel,
                            emailController: emailController),
                        PasswordTextFormField(
                            errorText: state is LoginFailure
                                ? state.passwordErrorMessage
                                : '',
                            forgotPasswordVisible: true,
                            label: LoginScreenText.passwordLabel,
                            passwordController: passwordController),
                      ],
                      buttonText: LoginScreenText.loginButton,
                      buttonOnPress: () {
                        context.read<LoginBloc>().add(LoginRequested(
                            email: emailController.text,
                            password: passwordController.text));
                      },
                      bottomTitleText: LoginScreenText.newToScratch,
                      bottomLinkText: LoginScreenText.createAccountHere,
                      destinationRoute: '/homeScreen',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
