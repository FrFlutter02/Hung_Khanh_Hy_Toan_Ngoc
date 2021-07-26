import 'package:flutter/material.dart';
import 'package:mobile_app/src/widgets/scratch_form.dart';

import '../constants/constant_colors.dart' as colors;
import '../constants/constant_text.dart' as text;
import '../widgets/logo.dart';

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
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.AppColor.white.withOpacity(0.2),
                      colors.AppColor.white,
                    ],
                    stops: [0.0, 0.9],
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
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
                              alignment: Alignment.topCenter,
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
                        Logo(
                          width: getWidth(102, screenWidth),
                          height: getHeight(28, screenHeight),
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
                      left: getWidth(isTabletScreen ? 171 : 25, screenWidth),
                      right: getWidth(isTabletScreen ? 171 : 25, screenWidth),
                      top: getHeight(20, screenHeight),
                      bottom: isTabletScreen ? getHeight(45, screenHeight) : 0,
                    ),
                    child: ScratchForm(
                      isTabletScreen: isTabletScreen,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
