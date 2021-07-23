import 'package:flutter/material.dart';

import '../constants/constant_colors.dart' as colors;
import '../constants/constant_text.dart' as text;

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  double _getMobileHeight(double designedPixel, double screenHeight) {
    return screenHeight * (designedPixel / 812);
  }

  double _getMobileWidth(double designedPixel, double screenWidth) {
    return screenWidth * (designedPixel / 375);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colors.AppColor.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 25, right: 25, top: _getMobileHeight(60, screenHeight)),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/login-signup-background.jpeg'),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: _getMobileHeight(285, screenHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: _getMobileWidth(102, screenWidth),
                  height: _getMobileHeight(28, screenHeight),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo_icon.png'))),
                ),
                SizedBox(height: _getMobileHeight(45, screenHeight)),
                Text(
                  text.SignupScreenText.startFromSratch.replaceFirst(' ', '\n'),
                  style: TextStyle(
                    color: colors.AppColor.primaryBlack,
                    fontFamily: 'Nunito-Bold',
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                top: _getMobileHeight(20, screenHeight),
                left: 25,
                right: 25,
                bottom: _getMobileHeight(45, screenHeight)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text.SignupScreenText.createAccountToContinue,
                  style: TextStyle(
                    color: colors.AppColor.primaryGrey,
                    fontFamily: 'Nunito-Regular',
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: _getMobileHeight(30, screenHeight)),
                // // // // // // //
                Text(
                  text.SignupScreenText.fullNameLabel,
                  style: TextStyle(
                      color: colors.AppColor.secondaryGrey,
                      fontFamily: 'Nunito-Regular',
                      fontSize: 14),
                ),
                SizedBox(
                  height: _getMobileHeight(15, screenHeight),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                colors.LoginScreenColor.textFieldBottomBorder,
                            width: 1)),
                    contentPadding: EdgeInsets.only(
                        bottom: _getMobileHeight(6, screenHeight)),
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                  ),
                  style: TextStyle(color: colors.AppColor.primaryBlack),
                ),
                SizedBox(height: _getMobileHeight(30, screenHeight)),
                // // // // // // //
                Text(
                  text.SignupScreenText.emailNameLabel,
                  style: TextStyle(
                      color: colors.AppColor.secondaryGrey,
                      fontFamily: 'Nunito-Regular',
                      fontSize: 14),
                ),
                SizedBox(
                  height: _getMobileHeight(15, screenHeight),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                colors.LoginScreenColor.textFieldBottomBorder,
                            width: 1)),
                    contentPadding: EdgeInsets.only(
                        bottom: _getMobileHeight(6, screenHeight)),
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                  ),
                  style: TextStyle(color: colors.AppColor.primaryBlack),
                ),
                SizedBox(height: _getMobileHeight(30, screenHeight)),
                // // // // // // //
                Text(
                  text.SignupScreenText.passwordLabel,
                  style: TextStyle(
                      color: colors.AppColor.secondaryGrey,
                      fontFamily: 'Nunito-Regular',
                      fontSize: 14),
                ),
                SizedBox(
                  height: _getMobileHeight(15, screenHeight),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                colors.LoginScreenColor.textFieldBottomBorder,
                            width: 1)),
                    contentPadding: EdgeInsets.only(
                        bottom: _getMobileHeight(6, screenHeight)),
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                  ),
                  style: TextStyle(color: colors.AppColor.primaryBlack),
                ),
                SizedBox(height: _getMobileHeight(30, screenHeight)),
                // // // // // // //
                Row(
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: 20,
                            height: _getMobileHeight(50, screenHeight)),
                        child: ElevatedButton(
                          onPressed: null,
                          child: Text(
                            text.SignupScreenText.createAccount,
                            style: TextStyle(
                              fontFamily: 'Nunito-Regular',
                              fontSize: 16,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  colors.AppColor.buttonGreen),
                              foregroundColor: MaterialStateProperty.all(
                                  colors.AppColor.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: _getMobileHeight(30, screenHeight)),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        text.SignupScreenText.alreadyHaveAnAccount,
                        style: TextStyle(
                          color: colors.AppColor.secondaryGrey,
                          fontFamily: 'Nunito-Regular',
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: _getMobileHeight(5, screenHeight)),
                      Text(
                        text.SignupScreenText.loginHere,
                        style: TextStyle(
                          color: colors.AppColor.buttonGreen,
                          fontFamily: 'Nunito-Bold',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
