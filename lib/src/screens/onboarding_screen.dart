import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../src/widgets/logo.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool displayOnTablet;
    bool isColorBackgroundTable = false;
    String fontFamilyFirstTitleTablet = '';
    double leterSpacingFirstTitle = 0;
    double sizedBoxWidthBetweenTwoButton = 0;
    double sizedBoxTopHeightFirstTitleTablet = 0;
    double sizedBoxBotHeightFirstTitleTablet = 0;
    double sizedBoxHeightBotSecondTitleTablet = 0;
    double paddingTopLogo = 0;
    double paddingHorizontalFirstTitleTablet = 0;
    double paddingHorizontalSecondTitleTablet = 0;
    double heightSecondTitleTablet = 0;
    double fontSizeFirstTitleTablet = 0;
    double fontSizeSecondtTitleTablet = 0;
    double fontSizeTextButton = 0;
    double scaleBackground = 0;
    double heightButton = 0;
    double widthButton = 0;
    double radiusButton = 0;
    double paddingHorizontalButton = 0;

    if (Device.get().isTablet) {
      isColorBackgroundTable = true;
      displayOnTablet = true;
      scaleBackground = 0.45;
      radiusButton = 8;
      fontSizeSecondtTitleTablet = 14;
      fontSizeTextButton = 16;
      leterSpacingFirstTitle = -0.5;
      fontSizeFirstTitleTablet = 40;
      widthButton = 300.w;
      sizedBoxWidthBetweenTwoButton = 20.w;
      paddingHorizontalButton = 135.w;
      paddingHorizontalSecondTitleTablet = 227.w;
      paddingHorizontalFirstTitleTablet = 134.w;
      paddingTopLogo = 80.h;
      sizedBoxTopHeightFirstTitleTablet = 131.h;
      sizedBoxBotHeightFirstTitleTablet = 8.h;
      heightSecondTitleTablet = 44.h;
      sizedBoxHeightBotSecondTitleTablet = 34.h;
      heightButton = 50.h;
      fontFamilyFirstTitleTablet = 'Nunito-SemiBold';
    } else {
      scaleBackground = 1;
      paddingTopLogo = 360.h;
      displayOnTablet = false;
      isColorBackgroundTable = false;
      fontFamilyFirstTitleTablet = 'Nunito-Bold';
    }

    return Scaffold(
      body: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/loginScreen');
          },
          child: SizedBox(
            height: 1024.h,
            child: Stack(
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image:
                          AssetImage("assets/images/inboarding_background.png"),
                      alignment: Alignment(0, 1.1),
                      fit: BoxFit.none,
                      scale: scaleBackground,
                    ))),
                Container(
                    decoration: BoxDecoration(
                        gradient: isColorBackgroundTable
                            ? GardientColorBackgroundOfOnboarding
                                .gradientColorTablet
                            : GardientColorBackgroundOfOnboarding
                                .gradientColorMobile)),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: paddingTopLogo),
                        child: Logo(),
                      ),
                    ),
                    displayOnTablet
                        ? Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                    height: sizedBoxTopHeightFirstTitleTablet),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          paddingHorizontalFirstTitleTablet),
                                  child: Text(
                                    OnboardingTabletText.firstTitle,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: fontSizeFirstTitleTablet,
                                        fontFamily: fontFamilyFirstTitleTablet,
                                        color: AppColor.primaryBlack,
                                        letterSpacing: leterSpacingFirstTitle),
                                  ),
                                ),
                                SizedBox(
                                    height: sizedBoxBotHeightFirstTitleTablet),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          paddingHorizontalSecondTitleTablet),
                                  height: heightSecondTitleTablet,
                                  alignment: Alignment.center,
                                  child: Text(
                                    OnboardingTabletText.secondTitle
                                        .replaceFirst(",", "\n"),
                                    style: TextStyle(
                                      fontSize: fontSizeSecondtTitleTablet,
                                      color: AppColor.secondaryGrey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                    height: sizedBoxHeightBotSecondTitleTablet),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: paddingHorizontalButton,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: widthButton,
                                          height: heightButton,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                                OnboardingTabletText.joinButton,
                                                style: TextStyle(
                                                  fontSize: fontSizeTextButton,
                                                )),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radiusButton),
                                              ),
                                              elevation: 0,
                                              primary: AppColor.green,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: sizedBoxWidthBetweenTwoButton),
                                      Expanded(
                                        child: Container(
                                          width: widthButton,
                                          height: heightButton,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              OnboardingTabletText
                                                  .learnMoreButton,
                                              style: TextStyle(
                                                color: AppColor.green,
                                                fontSize: fontSizeTextButton,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        radiusButton),
                                              ),
                                              elevation: 0,
                                              side: BorderSide(
                                                  width: 2.w,
                                                  color: (AppColor.green)),
                                              primary: AppColor.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
