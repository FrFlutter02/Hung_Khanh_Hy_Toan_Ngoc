import 'package:flutter/material.dart';
import 'package:mobile_app/src/validator.dart';
import 'package:mobile_app/src/widgets/form/form_body.dart';
import 'package:mobile_app/src/widgets/form/form_text_field.dart';

import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../widgets/form/form_header.dart';
import '../widgets/form/form_body.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isTabletScreen = false;
  final TextEditingController fullNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final Validator validator = new Validator();

  double getHeight(double designedPixel, double screenHeight) {
    return designedPixel / (isTabletScreen ? 1024 : 812) * screenHeight;
  }

  double getWidth(double designedPixel, double screenWidth) {
    return designedPixel / (isTabletScreen ? 768 : 375) * screenWidth;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth >= 768) {
            isTabletScreen = true;
          }
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
                height: screenHeight,
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
              ListView(
                shrinkWrap: true,
                children: [
                  FormHeader(
                    isTabletScreen: isTabletScreen,
                    formHeaderTitle: SignupScreenText.startFromSratch,
                  ),
                  FormBody(
                    isTabletScreen: isTabletScreen,
                    textFormFieldList: [
                      FormTextField(
                        textFieldLabel: SignupScreenText.fullNameLabel,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppText.fullNameErrorText;
                          }
                          return null;
                        },
                        controller: fullNameController,
                        isEmail: true,
                      ),
                      FormTextField(
                          textFieldLabel: SignupScreenText.emailNameLabel,
                          validator: (value) {
                            if (!validator.isValidEmail(emailController.text)) {
                              return AppText.emailErrorText;
                            }
                            return null;
                          },
                          controller: emailController),
                      FormTextField(
                        textFieldLabel: SignupScreenText.passwordLabel,
                        validator: (value) {
                          if (!validator
                              .isValidPassword(passwordController.text)) {
                            return AppText.passwordErrorText;
                          }
                          return null;
                        },
                        controller: passwordController,
                        isPassword: true,
                        forgotPasswordVisible: true,
                      ),
                    ],
                    titleText: SignupScreenText.alreadyHaveAnAccount,
                    linkText: SignupScreenText.loginHere,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
