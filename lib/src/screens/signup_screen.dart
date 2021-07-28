import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/validator.dart';

import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';

import '../widgets/form/email_text_form_field.dart';
import '../widgets/form/password_text_form_field.dart';
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
              children: [
                FormHeader(
                  isTabletScreen: isTabletScreen,
                  formHeaderTitle: isTabletScreen
                      ? SignupScreenText.startFromSratch
                      : SignupScreenText.startFromSratch
                          .replaceFirst(' ', '\n'),
                ),
                FormBody(
                  titleText: SignupScreenText.createAccountToContinue,
                  isTabletScreen: isTabletScreen,
                  textFormFieldList: [
                    _FullNameTextFormField(
                      label: SignupScreenText.fullNameLabel,
                      fullNameController: fullNameController,
                    ),
                    EmailTextFormField(
                        label: SignupScreenText.emailNameLabel,
                        emailController: emailController),
                    PasswordTextFormField(
                        label: SignupScreenText.passwordLabel,
                        passwordController: passwordController),
                  ],
                  footerTitleText: SignupScreenText.alreadyHaveAnAccount,
                  footerLinkText: SignupScreenText.loginHere,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FullNameTextFormField extends StatefulWidget {
  final TextEditingController fullNameController;
  final String label;

  const _FullNameTextFormField(
      {Key? key, required this.label, required this.fullNameController})
      : super(key: key);

  @override
  _FullNameTextFormFieldState createState() => _FullNameTextFormFieldState();
}

class _FullNameTextFormFieldState extends State<_FullNameTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: AppColor.secondaryGrey),
          ),
        ),
        SizedBox(height: 15),
        TextFormField(
          validator: (value) => Validator.fullNameValidator(value!),
          controller: widget.fullNameController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 6),
            errorMaxLines: 2,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: LoginScreenColor.textFieldBottomBorder,
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.green,
                width: 1,
              ),
            ),
            isDense: true,
          ),
          style: TextStyle(color: AppColor.primaryBlack),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
