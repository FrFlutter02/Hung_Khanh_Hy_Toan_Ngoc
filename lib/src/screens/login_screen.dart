import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/widgets/form/email_text_form_field.dart';
import 'package:mobile_app/src/widgets/form/password_text_form_field.dart';

import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';

import '../widgets/form/form_header.dart';
import '../widgets/form/form_body.dart';

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
      body: Stack(
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
                FormHeader(
                  isTabletScreen: isTabletScreen,
                  formHeaderTitle: LoginScreenText.welcome,
                ),
                FormBody(
                  titleText: LoginScreenText.pleaseLogin,
                  isTabletScreen: isTabletScreen,
                  textFormFieldList: [
                    EmailTextFormField(
                        label: LoginScreenText.emailLabel,
                        emailController: emailController),
                    PasswordTextFormField(
                        forgotPasswordVisible: true,
                        label: LoginScreenText.passwordLabel,
                        passwordController: passwordController),
                  ],
                  buttonText: LoginScreenText.loginButton,
                  footerTitleText: LoginScreenText.newToScratch,
                  footerLinkText: LoginScreenText.createAccountHere,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
