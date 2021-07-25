import 'package:flutter/material.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth >= 768) {
              return OnboardingTablet();
            } else {
              return OnboardingMoblie();
            }
          },
        ),
      ),
    );
  }
}

class OnboardingMoblie extends StatelessWidget {
  const OnboardingMoblie({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FittedBox(
                fit: BoxFit.none,
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Image.asset(
                    "assets/images/inboarding_background.png",
                    height: 475,
                    width: 639.95,
                  ),
                ),
              ),
            ],
          ),
          Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white60,
                Colors.white60,
                Colors.white60,
                Colors.white60,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          )),
          Center(
              child: Container(
            height: 39,
            width: 143,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/logo_icon.png",
                    height: 36.21, width: 25.24),
                Container(
                    height: 31,
                    width: 111,
                    child: Center(
                      child: Text(
                        AppText.iconText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.4,
                          color: AppColor.iconText,
                          fontFamily: 'Nunito',
                          height: 1,
                        ),
                      ),
                    ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class OnboardingTablet extends StatelessWidget {
  const OnboardingTablet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FittedBox(
                    fit: BoxFit.none,
                    child: Container(
                      margin: EdgeInsets.only(),
                      child: Image.asset(
                        "assets/images/inboarding_background.png",
                        scale: 0.4,
                        height: 1100,
                        width: 1300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white60,
                  Colors.white60,
                  Colors.white60,
                  Colors.white60,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            )),
            Column(
              children: [
                Expanded(
                  child: Container(
                    height: 98,
                    width: 276,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Expanded(
                          child: Image.asset("assets/images/logo_icon.png",
                              height: 92, width: 17.65),
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
                              fontFamily: 'Nunito',
                              height: 1,
                            ),
                          ),
                        )),
                        Spacer(
                          flex: 2,
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 146),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          OnboardingTabletText.firstTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'Nunito-Bold',
                            color: AppColor.primaryBlack,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 314,
                        child: Text(
                          OnboardingTabletText.secondTitle,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Nunito-Bold',
                            color: AppColor.secondaryGrey,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 34,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 239,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(OnboardingTabletText.joinButton),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 0,
                            primary: AppColor.buttonGreen,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 8.0),\

                        height: 50,
                        width: 239,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            OnboardingTabletText.learnMoreButton,
                            style: TextStyle(color: AppColor.buttonGreen),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            elevation: 0,
                            side: BorderSide(
                                width: 2, color: (AppColor.buttonGreen)),
                            primary: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(
                  flex: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
