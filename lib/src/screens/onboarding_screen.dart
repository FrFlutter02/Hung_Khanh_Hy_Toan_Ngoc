import 'package:flutter/material.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
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
                      Color.fromRGBO(225, 225, 225, 0),
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Color.fromRGBO(225, 225, 225, 0),
                      Color.fromRGBO(225, 225, 225, 0),
                      Color.fromRGBO(225, 225, 225, 0),
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
                              AppText.buttonGreen,
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
          ),
        ),
      ),
    );
  }
}
