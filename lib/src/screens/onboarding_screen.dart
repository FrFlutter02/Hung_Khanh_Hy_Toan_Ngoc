import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../src/widgets/logo.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';
import '../utils/screen_util.dart';

class OnboardingScreen extends StatelessWidget {
  bool isDeviceTablet() {
    if (Device.get().isTablet) {
      return true;
    } else {
      return false;
    }
  }

  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/loginScreen');
        },
        child: !isDeviceTablet()
            ? Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.none,
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            child: Image.asset(
                              "assets/images/inboarding_background.png",
                              scale: 0.5,
                              height: _screenUtil.height(460),
                              width: _screenUtil.width(700),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                          gradient: GardientColorBackgroundOfOnboarding
                              .gradientColorMobile)),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _screenUtil.width(116)),
                    child: Logo(),
                  ))
                ],
              )
            : Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: Container(
                              margin: EdgeInsets.only(),
                              child: Image.asset(
                                "assets/images/inboarding_background.png",
                                scale: 0.4,
                                height: _screenUtil.height(1100),
                                width: _screenUtil.width(1300),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          gradient: GardientColorBackgroundOfOnboarding
                              .gradientColorTablet)),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: _screenUtil.width(335),
                            right: _screenUtil.width(335),
                            top: 80),
                        child: Logo(),
                      ),
                      SizedBox(
                        height: _screenUtil.height(131),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _screenUtil.width(134)),
                        child: Text(
                          OnboardingTabletText.firstTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Nunito-SemiBold',
                              color: AppColor.primaryBlack,
                              height: _screenUtil.height(1.2),
                              letterSpacing: -0.5),
                        ),
                      ),
                      SizedBox(
                        height: _screenUtil.height(8),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: _screenUtil.width(227)),
                        height: _screenUtil.height(44),
                        alignment: Alignment.center,
                        child: Text(
                          OnboardingTabletText.secondTitle,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito-Regular',
                            color: AppColor.secondaryGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: _screenUtil.height(34),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _screenUtil.width(135)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: _screenUtil.width(300),
                                height: _screenUtil.height(50),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(OnboardingTabletText.joinButton,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Nunito-Regular')),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    elevation: 0,
                                    primary: AppColor.green,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: _screenUtil.width(20),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 8.0),
                                width: _screenUtil.width(300),
                                height: _screenUtil.height(50),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    OnboardingTabletText.learnMoreButton,
                                    style: TextStyle(
                                        color: AppColor.green,
                                        fontSize: 16,
                                        fontFamily: 'Nunito-Regular'),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
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
                ],
              ),
      ),
    );
  }
}
