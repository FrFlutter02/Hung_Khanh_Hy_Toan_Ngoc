import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/bloc/forgotpassword_bloc.dart';
import 'package:mobile_app/src/widgets/email_text_form_field.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';
import '../helper.dart';

// import 'package:http/http.dart' as http;

class ForgotPassword extends StatelessWidget {
  bool isDeviceTablet() {
    if (Device.get().isTablet) {
      return true;
    } else {
      return false;
    }
  }

  // Future sendEmail(
  //     {required String name,
  //     required String email,
  //     required String subject,
  //     required String message}) async {
  //   final serviceId = "service_8hvbq0e";
  //   final templateId = "template_lqm5m1r";
  //   final userId = "user_tT4tzTnftyAUGXffPVAS1";
  //   final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");

  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       'service_id': serviceId,
  //       'template_id': templateId,
  //       'user_id': userId,
  //       'template_params': {
  //         'user_name': name,
  //         'user_email': email,
  //         'user_subject': subject,
  //         'user_message': message
  //       }
  //     }),
  //   );
  //   print(response.body);
  // }

  TextEditingController emailTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    print(
        "Device Width: ${Device.screenWidth}, Device Height: ${Device.screenHeight}");
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => ForgotpasswordBloc(),
          child: BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
            builder: (context, state) {
              return Stack(
                children: [
                  isDeviceTablet()
                      ? Container(
                          height: height,
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
                          decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white60,
                              Colors.white60,
                              Colors.white70,
                              Colors.white70,
                              Colors.white70,
                              Colors.white,
                              Colors.white,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ))
                      : SizedBox.shrink(),
                  Column(
                    children: [
                      isDeviceTablet()
                          ? SizedBox(height: 82.5)
                          : SizedBox.shrink(),
                      isDeviceTablet()
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/logo_icon.png",
                                    height: Helper.height(36.21),
                                    width: Helper.width(25.24)),
                                SizedBox(
                                  width: Helper.width(10.65),
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
                                      fontFamily: 'Nunito-Regular',
                                    ),
                                  ),
                                )),
                              ],
                            )
                          : SizedBox.shrink(),
                      isDeviceTablet()
                          ? SizedBox(
                              height: Helper.height(135.5),
                            )
                          : SizedBox.shrink(),
                      isDeviceTablet()
                          ? Container(
                              child: Text(
                                "Start from Scratch",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: AppColor.primaryBlack,
                                  fontFamily: 'Nunito-Regular',
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                      isDeviceTablet()
                          ? SizedBox(
                              height: Helper.height(39),
                            )
                          : SizedBox.shrink(),
                      Container(
                        padding: isDeviceTablet()
                            ? EdgeInsets.only(
                                left: Helper.width(172),
                                right: Helper.width(172))
                            : EdgeInsets.only(left: Helper.width(25)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDeviceTablet()
                                  ? AppColor.secondaryGrey.withOpacity(0.1)
                                  : AppColor.white,
                              blurRadius: 10,
                              // offset: Offset(10, 10),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: isDeviceTablet()
                              ? EdgeInsets.only(left: Helper.width(50))
                              : EdgeInsets.only(left: 0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: isDeviceTablet()
                                          ? Helper.height(37)
                                          : Helper.height(60),
                                    ),
                                    !isDeviceTablet()
                                        ? Row(
                                            children: [
                                              Image.asset(
                                                  "assets/images/logo_icon.png",
                                                  height: Helper.height(33.21),
                                                  width: Helper.width(22.24)),
                                              SizedBox(
                                                width: Helper.width(10.65),
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
                                                    fontFamily:
                                                        'Nunito-Regular',
                                                  ),
                                                ),
                                              ))
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(
                                      height: Helper.height(47),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        ForgotPasswordText.title,
                                        style: TextStyle(
                                            fontSize:
                                                isDeviceTablet() ? 40 : 32,
                                            fontFamily: isDeviceTablet()
                                                ? "Nunito-Bold"
                                                : "Nunito-SemiBold",
                                            fontWeight: FontWeight.w800),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Helper.height(23),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          right: Helper.width(72)),
                                      child: Text(ForgotPasswordText.label,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize:
                                                  isDeviceTablet() ? 16 : 15,
                                              fontFamily: "Nunito-Regular",
                                              fontWeight: FontWeight.w400,
                                              color: isDeviceTablet()
                                                  ? AppColor.primaryGrey
                                                  : AppColor.primaryBlack,
                                              wordSpacing: Helper.width(1))),
                                    ),
                                    SizedBox(
                                      height: isDeviceTablet()
                                          ? Helper.height(57)
                                          : Helper.height(106),
                                    ),
                                    Container(
                                      padding: isDeviceTablet()
                                          ? EdgeInsets.only(
                                              right: Helper.width(57.17))
                                          : EdgeInsets.only(
                                              right: Helper.width(40)),
                                      child: Form(
                                        key: formKey,
                                        child: EmailTextFormField(
                                            emailController:
                                                emailTextEditingController,
                                            label: LoginScreenText.emailLabel),
                                      ),
                                    ),
                                    SizedBox(
                                      height: isDeviceTablet()
                                          ? Helper.height(18.58)
                                          : Helper.height(60),
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: Helper.height(50),
                                      padding: EdgeInsets.only(
                                          right: Helper.width(40)),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            // Navigator.of(context)
                                            //     .pushNamed('/loginScreen');
                                            BlocProvider.of<ForgotpasswordBloc>(
                                                    context)
                                                .add(Forgotedpassword(
                                              formKey.currentState.toString(),
                                              context,
                                            ));
                                            // sendEmail(
                                            //     email: "ngiahyiu@gmail.com",
                                            //     message:
                                            //         "Your password has been reset",
                                            //     name: "Hy",
                                            //     subject: "Reset password");
                                            // SnackBar(
                                            //     content: Text('Yay! A SnackBar!'));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: const Text(
                                                  'Email has been sent!!'),
                                            ));
                                          }
                                        },
                                        child: Text(
                                          "Send",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Regular",
                                              fontSize: 24),
                                        ),
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
              );
            },
          ),
        ),
      )),
    );
  }
}
