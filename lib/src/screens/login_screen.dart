import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../widgets/header_background.dart';
import '../widgets/reponsive.dart';
import '../widgets/text_form_field_custom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: _LoginScreenMobile(),
        tablet: _LoginScreenTablet(),
        desktop: Container(),
      ),
    );
  }
}

class _LoginScreenMobile extends StatelessWidget {
  const _LoginScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderBackground(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: LoginBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginScreenTablet extends StatelessWidget {
  const _LoginScreenTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(99),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/login-signup-background.jpeg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Container(
                  height: height,
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
                Positioned(
                  top: height * 0.1,
                  child: Container(
                    height: 40,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      LoginScreenText.welcome,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontFamily: "Nunito-SemiBold",
                          color: AppColor.primaryBlack,
                          fontSize: 30),
                    ),
                    const SizedBox(height: 45),
                    Container(
                      height: height * 0.44,
                      constraints: BoxConstraints(maxWidth: width * 0.55),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.secondaryGrey.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 20,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 40),
                        child: LoginBox(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailTextEditingController =
        new TextEditingController();
    TextEditingController passTextEditingController =
        new TextEditingController();
    double heightSpacing = 30;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            LoginScreenText.pleaseLogin,
            style: Theme.of(context).textTheme.subtitle1!,
          ),
        ),
        SizedBox(height: 40),
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFieldEmailCustom(
                  emailController: emailTextEditingController,
                  label: LoginScreenText.emailLabel),
              SizedBox(height: heightSpacing),
              TextFieldPasswordCustom(
                controller: passTextEditingController,
                label: LoginScreenText.passwordLabel,
              ),
            ],
          ),
        ),
        SizedBox(height: heightSpacing),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.buttonGreen,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pushNamed("/signupScreen");
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                LoginScreenText.loginButton,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: AppColor.white,
                    ),
              ),
            ),
          ),
        ),
        SizedBox(height: heightSpacing),
        Column(
          children: [
            Text(
              LoginScreenText.newToScratch,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: AppColor.primaryGrey),
            ),
            InkWell(
              child: Text(
                LoginScreenText.createAccountHere,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppColor.buttonGreen,
                    fontSize: 17,
                    fontFamily: "Nunito-SemiBold"),
              ),
              onTap: () {
                Navigator.of(context).pushNamed("/signupScreen");
              },
            ),
          ],
        ),
      ],
    );
  }
}
