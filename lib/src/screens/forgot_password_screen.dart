import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../src/widgets/logo.dart';
import '../blocs/forgot_password_bloc/forgot_password_bloc.dart';
import '../blocs/forgot_password_bloc/forgot_password_event.dart';
import '../blocs/forgot_password_bloc/forgot_password_state.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../utils/screen_util.dart';
import '../widgets/custom_button.dart';
import '../widgets/login_and_signup/email_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ScreenUtil _screenUtil = ScreenUtil();
  final TextEditingController emailTextEditingController =
      new TextEditingController();
  late bool showLogoMobile;
  late bool displayLogoTablet;
  late bool displayBackgroundTablet;
  late bool displayColorBackgroundTablet;
  late bool displayTabletLabel;
  late Color colorBackGround;
  late Color colorShadow;
  late Color lableTextColor;
  late String forGotPasswordTitle;
  late String fontFamilyTitle;
  late String lableText;
  late double paddingHorizonalTwoSide;
  late double paddingHorizonalContent;
  late double borderRadius;
  late double fontsizeTitle;
  late double fonsizeLabel;
  late double sizedBoxHeightUnderLabel;
  late double sizedBoxHeightUnderForm;
  late double sizeBoxHeightUnerCustomButton;
  late double sizeBoxHeightTopMobileLogo;
  late double sizeBoxHeightTopTabletLogo;
  late double sizeBoxHeightUnderTabletLogo;
  late double sizeBoxHeightUnderTabletLabel;
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    isDeviceTablet();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            Navigator.of(context).pushNamed('/loginScreen');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
              child: Stack(
            children: [
              displayBackgroundTablet
                  ? Container(
                      height: maxHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/login-signup-background.jpeg'),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              displayColorBackgroundTablet
                  ? Container(
                      height: maxHeight,
                      decoration: BoxDecoration(
                          gradient:
                              ColorOfBackgroundForgotPassword.gradientColor))
                  : SizedBox.shrink(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: sizeBoxHeightTopTabletLogo),
                  displayLogoTablet
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Logo()],
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: _screenUtil.height(sizeBoxHeightTopTabletLogo),
                  ),
                  displayTabletLabel
                      ? Text(
                          ForgotPasswordText.tabletLabel,
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColor.primaryBlack,
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: _screenUtil.height(sizeBoxHeightUnderTabletLabel),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizonalTwoSide),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorBackGround,
                        borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colorShadow,
                            blurRadius: 10,
                            offset: Offset(
                              10,
                              10,
                            ),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: paddingHorizonalContent),
                            child: Column(
                              children: [
                                SizedBox(height: sizeBoxHeightTopMobileLogo),
                                showLogoMobile
                                    ? Row(
                                        children: [Logo()],
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(
                                  height: _screenUtil.height(37),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    forGotPasswordTitle,
                                    style: TextStyle(
                                        fontSize: fontsizeTitle,
                                        fontFamily: fontFamilyTitle,
                                        fontWeight: FontWeight.w800),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  height: _screenUtil.height(23),
                                ),
                                Text(lableText,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: fonsizeLabel,
                                        fontWeight: FontWeight.w400,
                                        color: lableTextColor,
                                        wordSpacing: _screenUtil.width(1))),
                                SizedBox(height: sizedBoxHeightUnderLabel),
                                Form(
                                  key: formKey,
                                  child: EmailTextField(
                                      emailController:
                                          emailTextEditingController,
                                      label: LoginScreenText.emailLabel,
                                      errorText: state is ForgotPasswordFailure
                                          ? state.emailErrorMessage
                                          : ''),
                                ),
                                SizedBox(height: sizedBoxHeightUnderForm),
                                Container(
                                    width: double.maxFinite,
                                    height: _screenUtil.height(50),
                                    child: CustomButton(
                                      buttonOnPress: () => context
                                          .read<ForgotPasswordBloc>()
                                          .add(ForgotPasswordRequested(
                                              emailTextEditingController.text)),
                                      height: 50,
                                      width: Device.screenWidth,
                                      value: ForgotPasswordText.sendButton,
                                    )),
                                SizedBox(
                                  height: sizeBoxHeightUnerCustomButton,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
  }

  void isDeviceTablet() {
    if (Device.get().isTablet) {
      showLogoMobile = false;
      displayLogoTablet = true;
      displayBackgroundTablet = true;
      displayColorBackgroundTablet = true;
      displayTabletLabel = true;
      paddingHorizonalTwoSide = _screenUtil.width(172); //172,27.5
      paddingHorizonalContent = _screenUtil.width(50);
      borderRadius = 8;
      colorBackGround = AppColor.white;
      colorShadow = AppColor.primaryGrey.withOpacity(0.1);
      lableTextColor = AppColor.primaryGrey;
      forGotPasswordTitle = ForgotPasswordText.title.replaceFirst(" ", "\n");
      fontsizeTitle = 40;
      fontFamilyTitle = "Nunito-SemiBold";
      lableText = ForgotPasswordText.label;
      fonsizeLabel = 16;
      sizedBoxHeightUnderLabel = _screenUtil.height(57);
      sizedBoxHeightUnderForm = _screenUtil.height(18.58);
      sizeBoxHeightUnerCustomButton = _screenUtil.height(105);
      sizeBoxHeightTopMobileLogo = _screenUtil.height(37);
      sizeBoxHeightTopTabletLogo = _screenUtil.height(82.5);
      sizeBoxHeightUnderTabletLogo = _screenUtil.height(135.5);
      sizeBoxHeightUnderTabletLabel = _screenUtil.height(39);
    } else {
      showLogoMobile = true;
      displayLogoTablet = false;
      displayBackgroundTablet = false;
      displayColorBackgroundTablet = false;
      displayTabletLabel = false;
      paddingHorizonalTwoSide = _screenUtil.width(27.5); //172,27.5
      paddingHorizonalContent = _screenUtil.width(0);
      borderRadius = 0;
      colorBackGround = Colors.transparent;
      colorShadow = Colors.transparent;
      forGotPasswordTitle = ForgotPasswordText.title;
      fontsizeTitle = 32;
      fontFamilyTitle = "Nunito-SemiBold";
      lableText = ForgotPasswordText.label;
      fonsizeLabel = 15;
      lableTextColor = AppColor.primaryBlack;
      sizedBoxHeightUnderLabel = _screenUtil.height(106);
      sizedBoxHeightUnderForm = _screenUtil.height(60);
      sizeBoxHeightUnerCustomButton = _screenUtil.height(0);
      sizeBoxHeightTopMobileLogo = _screenUtil.height(60);
      sizeBoxHeightTopTabletLogo = _screenUtil.height(0);
      sizeBoxHeightUnderTabletLogo = _screenUtil.height(0);
      sizeBoxHeightUnderTabletLabel = _screenUtil.height(0);
    }
  }
}
