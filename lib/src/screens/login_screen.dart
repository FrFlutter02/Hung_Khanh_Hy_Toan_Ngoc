import 'package:flutter/material.dart';

import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/widgets/header_background.dart';
import 'package:mobile_app/src/widgets/text_form_field_custom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailTextEditingController =
        new TextEditingController();
    TextEditingController passTextEditingController =
        new TextEditingController();

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          HeaderBackground(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LoginScreenText.pleaseLogin,
                        style: Theme.of(context).textTheme.subtitle1!
                        // .copyWith(fontFamily: "Nunito-ExtraBoldItalic"),
                        ,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 47),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFieldEmailCustom(
                              emailController: emailTextEditingController,
                              label: LoginScreenText.emailLabel),
                          const SizedBox(height: 30),
                          TextFieldPasswordCustom(
                              controller: passTextEditingController,
                              label: LoginScreenText.passwordLabel),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.buttonGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
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
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      color: AppColor.white,
                                      // fontFamily: "Nunito",
                                    ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Text(
                          LoginScreenText.newToScratch,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: AppColor.primaryGrey,
                                  fontFamily: "Nunito-Regular"),
                        ),
                        Text(
                          LoginScreenText.createAccountHere,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: AppColor.buttonGreen,
                                  fontSize: 17,
                                  fontFamily: "Nunito-Bold"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
