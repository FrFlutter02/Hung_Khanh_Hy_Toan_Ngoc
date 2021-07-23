import 'package:flutter/material.dart';

import '../constants/constant_colors.dart' as colors;
import '../constants/constant_text.dart' as text;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isTabletScreen = false;

  double getHeight(double designedPixel, double screenHeight) {
    return designedPixel / (isTabletScreen ? 1024 : 812) * screenHeight;
  }

  double getWidth(double designedPixel, double screenWidth) {
    return designedPixel / (isTabletScreen ? 768 : 375) * screenWidth;
  }

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
            isTabletScreen = true;
          }
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: getWidth(25, screenWidth),
                    right: getWidth(25, screenWidth),
                    top: getHeight(isTabletScreen ? 80 : 60, screenHeight),
                    bottom: getHeight(36, screenHeight)),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100)),
                  image: isTabletScreen
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/login-signup-background.jpeg'),
                        ),
                ),
                width: MediaQuery.of(context).size.width,
                height: getHeight(isTabletScreen ? 305 : 285, screenHeight),
                child: Column(
                  mainAxisAlignment: isTabletScreen
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  crossAxisAlignment: isTabletScreen
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: getWidth(102, screenWidth),
                      height: getHeight(28, screenHeight),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/logo_icon.png'))),
                    ),
                    SizedBox(height: getHeight(45, screenHeight)),
                    Text(
                      isTabletScreen
                          ? text.SignupScreenText.startFromSratch
                          : text.SignupScreenText.startFromSratch
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
                  top: getHeight(20, screenHeight),
                  left: getWidth(isTabletScreen ? 171 : 25, screenWidth),
                  right: getWidth(isTabletScreen ? 171 : 25, screenWidth),
                  bottom: isTabletScreen ? getHeight(45, screenHeight) : 0,
                ),
                child: Card(
                  elevation: isTabletScreen ? 10 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: isTabletScreen ? getWidth(50, screenWidth) : 0,
                        right: isTabletScreen ? getWidth(50, screenWidth) : 0,
                        top: isTabletScreen ? getHeight(50, screenWidth) : 0,
                        bottom:
                            isTabletScreen ? getHeight(50, screenWidth) : 0),
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
                        SizedBox(height: getHeight(30, screenHeight)),
                        // // // // // // //
                        Text(
                          text.SignupScreenText.fullNameLabel,
                          style: TextStyle(
                              color: colors.AppColor.secondaryGrey,
                              fontFamily: 'Nunito-Regular',
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: getHeight(15, screenHeight),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color:
                                  colors.LoginScreenColor.textFieldBottomBorder,
                              width: getWidth(1, screenWidth),
                            )),
                            contentPadding: EdgeInsets.only(
                                bottom: getHeight(6, screenHeight)),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                          ),
                          style: TextStyle(color: colors.AppColor.primaryBlack),
                        ),
                        SizedBox(height: getHeight(30, screenHeight)),
                        // // // // // // //
                        Text(
                          text.SignupScreenText.emailNameLabel,
                          style: TextStyle(
                              color: colors.AppColor.secondaryGrey,
                              fontFamily: 'Nunito-Regular',
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: getHeight(15, screenHeight),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: colors
                                        .LoginScreenColor.textFieldBottomBorder,
                                    width: 1)),
                            contentPadding: EdgeInsets.only(
                                bottom: getHeight(6, screenHeight)),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                          ),
                          style: TextStyle(color: colors.AppColor.primaryBlack),
                        ),
                        SizedBox(height: getHeight(30, screenHeight)),
                        // // // // // // //
                        Text(
                          text.SignupScreenText.passwordLabel,
                          style: TextStyle(
                              color: colors.AppColor.secondaryGrey,
                              fontFamily: 'Nunito-Regular',
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: getHeight(15, screenHeight),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: colors
                                        .LoginScreenColor.textFieldBottomBorder,
                                    width: 1)),
                            contentPadding: EdgeInsets.only(
                                bottom: getHeight(6, screenHeight)),
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                          ),
                          style: TextStyle(color: colors.AppColor.primaryBlack),
                        ),
                        SizedBox(height: getHeight(30, screenHeight)),
                        // // // // // // //
                        Row(
                          children: [
                            Expanded(
                              child: ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: 20,
                                    height: getHeight(50, screenHeight)),
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              colors.AppColor.buttonGreen),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              colors.AppColor.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: getHeight(30, screenHeight)),
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
                              SizedBox(height: getHeight(5, screenHeight)),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
