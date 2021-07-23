import 'package:flutter/material.dart';

import '../constants/constant_colors.dart' as colors;
import '../constants/constant_text.dart' as text;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isTabletScreen = false;

  double getPhoneHeight(double designedPixel, double screenHeight) {
    return designedPixel / (isTabletScreen ? 768 : 812) * screenHeight;
  }

  double getPhoneWidth(double designedPixel, double screenWidth) {
    return designedPixel / (isTabletScreen ? 1024 : 375) * screenWidth;
  }

  // double getTabletHeight(double designedPixel, double screenHeight) {
  //   return designedPixel / 768 * screenHeight;
  // }

  // double getTabletWidth(double designedPixel, double screenWidth) {
  //   return designedPixel / 1024 * screenWidth;
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colors.AppColor.white,
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth >= 768) {
            setState(() {
              isTabletScreen = true;
            });
          }
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: 25, right: 25, top: getPhoneHeight(60, screenHeight)),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/login-signup-background.jpeg'),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: getPhoneHeight(285, screenHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: getPhoneWidth(102, screenWidth),
                      height: getPhoneHeight(28, screenHeight),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/logo_icon.png'))),
                    ),
                    SizedBox(height: getPhoneHeight(45, screenHeight)),
                    Text(
                      text.SignupScreenText.startFromSratch
                          .replaceFirst(' ', '\n'),
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
                    top: getPhoneHeight(20, screenHeight),
                    left: 25,
                    right: 25,
                    bottom: getPhoneHeight(45, screenHeight)),
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
                    SizedBox(height: getPhoneHeight(30, screenHeight)),
                    // // // // // // //
                    Text(
                      text.SignupScreenText.fullNameLabel,
                      style: TextStyle(
                          color: colors.AppColor.secondaryGrey,
                          fontFamily: 'Nunito-Regular',
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: getPhoneHeight(15, screenHeight),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colors
                                    .LoginScreenColor.textFieldBottomBorder,
                                width: 1)),
                        contentPadding: EdgeInsets.only(
                            bottom: getPhoneHeight(6, screenHeight)),
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                      ),
                      style: TextStyle(color: colors.AppColor.primaryBlack),
                    ),
                    SizedBox(height: getPhoneHeight(30, screenHeight)),
                    // // // // // // //
                    Text(
                      text.SignupScreenText.emailNameLabel,
                      style: TextStyle(
                          color: colors.AppColor.secondaryGrey,
                          fontFamily: 'Nunito-Regular',
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: getPhoneHeight(15, screenHeight),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colors
                                    .LoginScreenColor.textFieldBottomBorder,
                                width: 1)),
                        contentPadding: EdgeInsets.only(
                            bottom: getPhoneHeight(6, screenHeight)),
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                      ),
                      style: TextStyle(color: colors.AppColor.primaryBlack),
                    ),
                    SizedBox(height: getPhoneHeight(30, screenHeight)),
                    // // // // // // //
                    Text(
                      text.SignupScreenText.passwordLabel,
                      style: TextStyle(
                          color: colors.AppColor.secondaryGrey,
                          fontFamily: 'Nunito-Regular',
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: getPhoneHeight(15, screenHeight),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colors
                                    .LoginScreenColor.textFieldBottomBorder,
                                width: 1)),
                        contentPadding: EdgeInsets.only(
                            bottom: getPhoneHeight(6, screenHeight)),
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                      ),
                      style: TextStyle(color: colors.AppColor.primaryBlack),
                    ),
                    SizedBox(height: getPhoneHeight(30, screenHeight)),
                    // // // // // // //
                    Row(
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: 20,
                                height: getPhoneHeight(50, screenHeight)),
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
                    SizedBox(height: getPhoneHeight(30, screenHeight)),
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
                          SizedBox(height: getPhoneHeight(5, screenHeight)),
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
          );
        },
      ),
    );
  }
}
