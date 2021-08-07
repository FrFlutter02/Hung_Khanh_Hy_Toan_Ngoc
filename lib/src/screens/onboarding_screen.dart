import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../src/widgets/logo.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';
import '../utils/screen_util.dart';

class OnboardingScreen extends StatelessWidget {
  final ScreenUtil _screenUtil = ScreenUtil();
  late bool displayOnTablet;
  late bool isColorBackgroundTable;
  late String fontFamilyFirstTitleTablet;
  late double leterSpacingFirstTitle;
  late double sizeBoxHeightTopBackgroundImage;
  late double sizedBoxWidthBetweenTwoButton;
  late double sizedBoxTopHeightFirstTitleTablet;
  late double sizedBoxBotHeightFirstTitleTablet;
  late double sizedBoxBotSecondTitleTablet;
  late double paddingHorizontalLogo;
  late double paddingTopLogo;
  late double paddingHorizontalFirstTitleTablet;
  late double paddingHorizontalSecondTitleTablet;
  late double heightSecondTitleTablet;
  late double fontSizeFirstTitleTablet;
  late double fontSizeSecondtTitleTablet;
  late double fontSizeTextButton;
  late double scaleBackground;
  late double hightButton;
  late double widthButton;
  late double heightBackground;
  late double widthBackground;
  late double radiusButton;

  late double paddingHorizontalButton;
  void isDeviceTablet() {
    if (Device.get().isTablet) {
      scaleBackground = 0.47;
      heightBackground = _screenUtil.height(1000);
      widthBackground = _screenUtil.width(1200);
      paddingHorizontalLogo = _screenUtil.width(335);
      paddingTopLogo = _screenUtil.height(80);
      displayOnTablet = true;
      sizeBoxHeightTopBackgroundImage = 590;
      leterSpacingFirstTitle = -0.5;
      isColorBackgroundTable = true;
      fontSizeFirstTitleTablet = 40;
      fontFamilyFirstTitleTablet = 'Nunito-SemiBold';
      paddingHorizontalFirstTitleTablet = _screenUtil.width(134);
      sizedBoxTopHeightFirstTitleTablet = _screenUtil.height(131);
      sizedBoxBotHeightFirstTitleTablet = _screenUtil.height(8);

      paddingHorizontalSecondTitleTablet = 227;
      heightSecondTitleTablet = 44;
      fontSizeSecondtTitleTablet = 14;
      sizedBoxBotSecondTitleTablet = 34;
      fontSizeTextButton = 16;
      hightButton = 50;
      widthButton = 300;
      radiusButton = 8;
      sizedBoxWidthBetweenTwoButton = 20;
      paddingHorizontalButton = 135;
    } else {
      scaleBackground = 1;
      heightBackground = _screenUtil.height(490);
      widthBackground = _screenUtil.width(700);
      paddingHorizontalLogo = _screenUtil.width(116);
      paddingTopLogo = _screenUtil.height(360);
      displayOnTablet = false;
      sizeBoxHeightTopBackgroundImage = 300;
      isColorBackgroundTable = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    isDeviceTablet();
    return Scaffold(
      body: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/loginScreen');
          },
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: sizeBoxHeightTopBackgroundImage,
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.none,
                      child: Image.asset(
                        "assets/images/inboarding_background.png",
                        scale: scaleBackground,
                      ),
                    ),
                  ),
                ],
              ),
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
                      ? Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: _screenUtil
                                    .height(sizedBoxTopHeightFirstTitleTablet),
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
                                height: _screenUtil
                                    .height(sizedBoxBotHeightFirstTitleTablet),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _screenUtil.width(
                                        paddingHorizontalSecondTitleTablet)),
                                height:
                                    _screenUtil.height(heightSecondTitleTablet),
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
                                height: _screenUtil
                                    .height(sizedBoxBotSecondTitleTablet),
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
                                        height: _screenUtil.height(hightButton),
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
                                      width: _screenUtil
                                          .width(sizedBoxWidthBetweenTwoButton),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: _screenUtil.width(widthButton),
                                        height: _screenUtil.height(hightButton),
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
          )),
    );
  }
}
