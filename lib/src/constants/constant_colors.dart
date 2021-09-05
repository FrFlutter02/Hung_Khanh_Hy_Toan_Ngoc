import 'package:flutter/material.dart';

class AppColor {
  static const green = Color(0xff30BE76);
  static const iconText = Color(0xff363837);
  static const primaryBlack = Color(0xff030F09);
  static const primaryGrey = Color(0xff606060);
  static const secondaryGrey = Color(0xffA8A8A8);
  static const white = Color(0xffffffff);
}

class LoginScreenColor {
  static const resetPassword = Color(0xff9A9EF7);
  static const textFieldBottomBorder = Color(0xffCCCCCC);
}

class ColorOfBackgroundForgotPassword {
  static const gradientColor = LinearGradient(
    colors: [
      Colors.white54,
      Colors.white54,
      Colors.white54,
      Colors.white70,
      Colors.white70,
      Colors.white,
      Colors.white,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class GardientColorBackgroundOfOnboarding {
  static const gradientColorTablet = LinearGradient(
    colors: [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white60,
      Colors.white60,
      Colors.white60,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const gradientColorMobile = LinearGradient(
    colors: [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white60,
      Colors.white60,
      Colors.white38,
      Colors.white10,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class NewRecipeScreenColor {
  static const borderUnderlineTextFieldColor = Color(0xffCCCCCC);
  static const borderButtonColor = Color(0xff979797);
  static const leadingTextColor = Color(0xff767676);
  static const buttonIngredientsColor = Color(0xffECF0EC);
}

class SearchScreenColor {
  static const primaryGrey = Color(0xffe6e6e6);
}
