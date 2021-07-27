import 'package:flutter/material.dart';

import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';
import '../widgets/text_from_field_custom.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth >= 768) {
              return ForgotPasswordTablet();
            } else {
              return ForgotPasswordMoblie();
            }
          },
        ),
      ),
    );
  }
}

class ForgotPasswordMoblie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailTextEditingController =
        new TextEditingController();
    return Container(
      padding: EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Image.asset("assets/images/logo_icon.png",
                        height: 36.21, width: 25.24),
                    SizedBox(
                      width: 10.65,
                    ),
                    Container(
                        child: Center(
                      child: Text(
                        AppText.iconText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.4,
                          color: AppColor.iconText,
                          fontFamily: 'Nunito-Bold',
                          height: 1,
                        ),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 47,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ForgotPasswordText.title,
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: "Nunito-SemiBold",
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(right: 72),
                  child: Text(ForgotPasswordText.label,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Nunito-Regular",
                          fontWeight: FontWeight.w400,
                          wordSpacing: 1)),
                ),
                SizedBox(
                  height: 106,
                ),
                Container(
                  padding: EdgeInsets.only(right: 40),
                  child: Form(
                    key: formKey,
                    child: TextFieldEmailCustom(
                        emailController: emailTextEditingController,
                        label: LoginScreenText.emailLabel),
                  ),

                  // child: TextFormField(
                  //   decoration: new InputDecoration(
                  //       labelText: LoginScreenText.emailLabel,
                  //       labelStyle: TextStyle(
                  //           color: AppColor.secondaryGrey, fontSize: 14),
                  //       enabledBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.grey),

                  //         //  when the TextFormField in unfocused
                  //       ),
                  //       focusedBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.grey),
                  //         //  when the TextFormField in focused
                  //       ),
                  //       border: UnderlineInputBorder(),
                  //       hintText: "user@email.com"),
                  // ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  width: double.maxFinite,
                  height: 50,
                  padding: EdgeInsets.only(right: 40),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Send",
                      style:
                          TextStyle(fontFamily: "Nunito-Regular", fontSize: 24),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 0,
                      primary: AppColor.buttonGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
