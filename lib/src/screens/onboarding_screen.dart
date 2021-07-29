import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';

import '../helper.dart';

class OnboardingScreen extends StatelessWidget {
  bool isDeviceTablet() {
    if (Device.get().isTablet) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Device isPhone: ${Device.get().isPhone}");
    print("Device isAndroid: ${Device.get().isAndroid}");
    print("Device isIos: ${Device.get().isIos}");
    print(Device.size);
//Quick methods to access the physical device width and height
    print("Device Width: ${Device.width}, Device Height: ${Device.height}");

//To get the actual screen size (Which is same as what MediaQuery gives)
    print("ctual screen size");
    print(Device.screenSize);
//Quick methods to access the screen width and height
    print(
        "Device Width: ${Device.screenWidth}, Device Height: ${Device.screenHeight}");
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/loginScreen');
          },
          child: !isDeviceTablet()
              ? Stack(
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
                              scale: 0.3,
                              height: Helper.height(400),
                              width: Helper.width(780),
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
                          Colors.white,
                          Colors.white,
                          Colors.white60,
                          Colors.white60,
                          Colors.white60,
                          Colors.white60,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    )),
                    Center(
                        child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Helper.width(116)),
                      child: Row(
                        children: [
                          Image.asset("assets/images/logo_icon.png",
                              height: Helper.height(36.21),
                              width: Helper.width(25.24)),
                          Container(
                              width: Helper.width(111),
                              child: Center(
                                child: Text(
                                  AppText.iconText,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: Helper.width(0.4),
                                    color: AppColor.iconText,
                                    fontFamily: 'Nunito-Regular',
                                  ),
                                ),
                              ))
                        ],
                      ),
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
                          FittedBox(
                            fit: BoxFit.none,
                            child: Container(
                              margin: EdgeInsets.only(),
                              child: Image.asset(
                                "assets/images/inboarding_background.png",
                                scale: 0.4,
                                height: Helper.height(1100),
                                width: Helper.width(1300),
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
                            height: Helper.height(98),
                            width: Helper.width(276),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(
                                  flex: 2,
                                ),
                                Expanded(
                                  child: Image.asset(
                                      "assets/images/logo_icon.png",
                                      height: Helper.height(25.07),
                                      width: Helper.width(17.29)),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: Helper.width(134)),
                          child: Text(
                            OnboardingTabletText.firstTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Nunito-SemiBold',
                                color: AppColor.primaryBlack,
                                height: Helper.height(1.2),
                                letterSpacing: -0.5),
                          ),
                        ),
                        SizedBox(
                          height: Helper.height(8),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Helper.width(227)),
                          height: Helper.height(44),
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
                          height: Helper.height(34),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Helper.width(135)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: Helper.width(300),
                                  height: Helper.height(50),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(OnboardingTabletText.joinButton,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Nunito-Regular')),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      elevation: 0,
                                      primary: AppColor.green,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Helper.width(20),
                              ),
                              Expanded(
                                child: Container(
                                  // margin: EdgeInsets.only(left: 8.0),\
                                  width: Helper.width(300),
                                  height: Helper.height(50),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      elevation: 0,
                                      side: BorderSide(
                                          width: Helper.width(2),
                                          color: (AppColor.green)),
                                      primary: AppColor.white,
                                    ),
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
      ),
    );
  }
}
