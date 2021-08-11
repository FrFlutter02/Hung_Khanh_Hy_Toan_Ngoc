import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../src/widgets/logo.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../utils/screen_util.dart';

class OnboardingScreen extends StatelessWidget {
  final ScreenUtil _screenUtil = ScreenUtil();
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
      widthButton = _screenUtil.width(300);
      sizedBoxWidthBetweenTwoButton = _screenUtil.width(20);
      paddingHorizontalButton = _screenUtil.width(135);
      paddingHorizontalSecondTitleTablet = _screenUtil.width(227);
      paddingHorizontalFirstTitleTablet = _screenUtil.width(134);
      paddingTopLogo = _screenUtil.height(80);
      sizedBoxTopHeightFirstTitleTablet = _screenUtil.height(131);
      sizedBoxBotHeightFirstTitleTablet = _screenUtil.height(8);
      heightSecondTitleTablet = _screenUtil.height(44);
      sizedBoxHeightBotSecondTitleTablet = _screenUtil.height(34);
      heightButton = _screenUtil.height(50);
      fontFamilyFirstTitleTablet = 'Nunito-SemiBold';
    } else {
      scaleBackground = 1;
      paddingTopLogo = _screenUtil.height(360);
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
            height: _screenUtil.height(1024),
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
                                  height: _screenUtil.height(
                                      sizedBoxTopHeightFirstTitleTablet),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _screenUtil.width(
                                          paddingHorizontalFirstTitleTablet)),
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
                                  height: _screenUtil.height(
                                      sizedBoxBotHeightFirstTitleTablet),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _screenUtil.width(
                                          paddingHorizontalSecondTitleTablet)),
                                  height: _screenUtil
                                      .height(heightSecondTitleTablet),
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
                                  height: _screenUtil.height(
                                      sizedBoxHeightBotSecondTitleTablet),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _screenUtil
                                          .width(paddingHorizontalButton)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: _screenUtil.width(widthButton),
                                          height:
                                              _screenUtil.height(heightButton),
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
                                        width: _screenUtil.width(
                                            sizedBoxWidthBetweenTwoButton),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: _screenUtil.width(widthButton),
                                          height:
                                              _screenUtil.height(heightButton),
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
                                                  width: _screenUtil.width(2),
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
