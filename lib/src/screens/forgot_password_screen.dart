import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../src/widgets/logo.dart';
import '../blocs/forgot_password_bloc/forgot_password_bloc.dart';
import '../blocs/forgot_password_bloc/forgot_password_event.dart';
import '../blocs/forgot_password_bloc/forgot_password_state.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/login_and_signup/email_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();

    bool showLogoMobile;
    bool displayLogoTablet;
    bool displayBackgroundTablet;
    bool displayColorBackgroundTablet;
    bool displayTabletLabel;
    Color colorBackGround;
    Color colorShadow;
    Color lableTextColor;
    String forGotPasswordTitle;
    String fontFamilyTitle;
    String lableText;
    double paddingHorizonalTwoSide;
    double paddingHorizonalContent;
    double borderRadius;
    double fontsizeTitle;
    double fonsizeLabel;
    double sizedBoxHeightUnderLabel;
    double sizedBoxHeightUnderForm;
    double sizeBoxHeightUnerCustomButton;
    double sizeBoxHeightTopMobileLogo;
    double sizeBoxHeightTopTabletLogo;
    double sizeBoxHeightUnderTabletLogo;
    double sizeBoxHeightUnderTabletLabel;

    if (Device.get().isTablet) {
      showLogoMobile = false;
      displayLogoTablet = true;
      displayBackgroundTablet = true;
      displayColorBackgroundTablet = true;
      displayTabletLabel = true;
      paddingHorizonalTwoSide = 172.w;
      paddingHorizonalContent = 50.w;
      borderRadius = 8;
      colorBackGround = AppColor.white;
      colorShadow = AppColor.primaryGrey.withOpacity(0.1);
      lableTextColor = AppColor.primaryGrey;
      forGotPasswordTitle = ForgotPasswordText.title.replaceFirst(" ", "\n");
      fontsizeTitle = 40;
      fontFamilyTitle = "Nunito-SemiBold";
      lableText = ForgotPasswordText.label;
      fonsizeLabel = 16;
      sizedBoxHeightUnderLabel = 57.h;
      sizedBoxHeightUnderForm = 18.58.h;
      sizeBoxHeightUnerCustomButton = 105.h;
      sizeBoxHeightTopMobileLogo = 37.h;
      sizeBoxHeightTopTabletLogo = 82.5.h;
      sizeBoxHeightUnderTabletLogo = 135.5.h;
      sizeBoxHeightUnderTabletLabel = 39.h;
    } else {
      showLogoMobile = true;
      displayLogoTablet = false;
      displayBackgroundTablet = false;
      displayColorBackgroundTablet = false;
      displayTabletLabel = false;
      paddingHorizonalTwoSide = 27.5.w;
      paddingHorizonalContent = 0.w;
      borderRadius = 0;
      colorBackGround = Colors.transparent;
      colorShadow = Colors.transparent;
      forGotPasswordTitle = ForgotPasswordText.title;
      fontsizeTitle = 32;
      fontFamilyTitle = "Nunito-SemiBold";
      lableText = ForgotPasswordText.label;
      fonsizeLabel = 15;
      lableTextColor = AppColor.primaryBlack;
      sizedBoxHeightUnderLabel = 106.h;
      sizedBoxHeightUnderForm = 60.h;
      sizeBoxHeightUnerCustomButton = 0.h;
      sizeBoxHeightTopMobileLogo = 60.h;
      sizeBoxHeightTopTabletLogo = 0.h;
      sizeBoxHeightUnderTabletLogo = 0.h;
      sizeBoxHeightUnderTabletLabel = 0.h;
    }

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
                    height: sizeBoxHeightUnderTabletLogo.h,
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
                    height: sizeBoxHeightUnderTabletLabel.h,
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
                                  height: 37.h,
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
                                  height: 23.h,
                                ),
                                Text(lableText,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: fonsizeLabel,
                                        fontWeight: FontWeight.w400,
                                        color: lableTextColor,
                                        wordSpacing: 1.w)),
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
                                    height: 50.h,
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
}
