import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import '../../src/widgets/logo.dart';
import '../services/user_services.dart';
import '../../src/widgets/email_text_form_field.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';
import '../screen_util.dart';

class ForgotPassword extends StatelessWidget {
  bool isDeviceTablet() {
    if (Device.get().isTablet) {
      return true;
    } else {
      return false;
    }
  }

  final UserServices userServices = UserServices();
  final ScreenUtil _screenUtil = ScreenUtil();
  final TextEditingController emailTextEditingController =
      new TextEditingController();
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Stack(
        children: [
          isDeviceTablet()
              ? Container(
                  height: maxHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(99),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/login-signup-background.jpeg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                )
              : SizedBox.shrink(),
          isDeviceTablet()
              ? Container(
                  height: maxHeight,
                  decoration: BoxDecoration(
                      gradient: ColorOfBackgroundForgotPassword.gradientColor))
              : SizedBox.shrink(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isDeviceTablet() ? SizedBox(height: 82.5) : SizedBox.shrink(),
              isDeviceTablet()
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Logo(
                            width: _screenUtil.width(99),
                            height: _screenUtil.width(22))
                      ],
                    )
                  : SizedBox.shrink(),
              isDeviceTablet()
                  ? SizedBox(
                      height: _screenUtil.height(135.5),
                    )
                  : SizedBox.shrink(),
              isDeviceTablet()
                  ? Text(
                      ForgotPasswordText.tabletLabel,
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColor.primaryBlack,
                      ),
                    )
                  : SizedBox.shrink(),
              isDeviceTablet()
                  ? SizedBox(
                      height: _screenUtil.height(39),
                    )
                  : SizedBox.shrink(),
              Padding(
                padding: isDeviceTablet()
                    ? EdgeInsets.symmetric(horizontal: _screenUtil.width(172))
                    : EdgeInsets.symmetric(horizontal: _screenUtil.width(27.5)),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        isDeviceTablet() ? AppColor.white : Colors.transparent,
                    borderRadius: isDeviceTablet()
                        ? BorderRadius.all(
                            Radius.circular(8),
                          )
                        : BorderRadius.all(
                            Radius.circular(0),
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: isDeviceTablet()
                            ? AppColor.primaryGrey.withOpacity(0.1)
                            : Colors.transparent,
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
                        padding: isDeviceTablet()
                            ? EdgeInsets.symmetric(
                                horizontal: _screenUtil.width(50))
                            : EdgeInsets.symmetric(
                                horizontal: _screenUtil.width(0)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: isDeviceTablet()
                                  ? _screenUtil.height(37)
                                  : _screenUtil.height(60),
                            ),
                            isDeviceTablet()
                                ? SizedBox.shrink()
                                : Row(
                                    children: [
                                      Logo(
                                          width: _screenUtil.width(99),
                                          height: _screenUtil.width(22))
                                    ],
                                  ),
                            SizedBox(
                              height: _screenUtil.height(37),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                isDeviceTablet()
                                    ? ForgotPasswordText.title
                                        .replaceFirst(" ", "\n")
                                    : ForgotPasswordText.title,
                                style: TextStyle(
                                    fontSize: isDeviceTablet() ? 40 : 32,
                                    fontFamily: isDeviceTablet()
                                        ? "Nunito-Bold"
                                        : "Nunito-SemiBold",
                                    fontWeight: FontWeight.w800),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              height: _screenUtil.height(23),
                            ),
                            Text(ForgotPasswordText.label,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: isDeviceTablet() ? 16 : 15,
                                    fontWeight: FontWeight.w400,
                                    color: isDeviceTablet()
                                        ? AppColor.primaryGrey
                                        : AppColor.primaryBlack,
                                    wordSpacing: _screenUtil.width(1))),
                            SizedBox(
                              height: isDeviceTablet()
                                  ? _screenUtil.height(57)
                                  : _screenUtil.height(106),
                            ),
                            Form(
                              key: formKey,
                              child: EmailTextFormField(
                                  emailController: emailTextEditingController,
                                  label: LoginScreenText.emailLabel),
                            ),
                            SizedBox(
                              height: isDeviceTablet()
                                  ? _screenUtil.height(18.58)
                                  : _screenUtil.height(60),
                            ),
                            Container(
                              width: double.maxFinite,
                              height: _screenUtil.height(50),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (await userServices.userDidExist(
                                        emailTextEditingController.text)) {
                                      Navigator.of(context)
                                          .pushNamed('/loginScreen');
                                      FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: emailTextEditingController
                                                  .text);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(ForgotPasswordText
                                            .snackbarContentScuess),
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(ForgotPasswordText
                                            .snackbarContentEmailExist),
                                      ));
                                    }
                                  }
                                },
                                child: Text(
                                  ForgotPasswordText.sendButton,
                                  style: TextStyle(fontSize: 24),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 0,
                                  primary: AppColor.green,
                                ),
                              ),
                            ),
                            isDeviceTablet()
                                ? SizedBox(
                                    height: 105,
                                  )
                                : SizedBox.shrink()
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
      )),
    );
  }
}
