import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';
import '../custom_button.dart';

class LoginAndSignupBody extends StatelessWidget {
  final List<Widget> textFieldList;
  final String titleText;
  final String buttonText;
  final void Function() buttonOnPress;
  final String bottomTitleText;
  final String bottomLinkText;
  final String destinationRoute;
  final bool isTabletScreen;

  const LoginAndSignupBody(
      {required this.textFieldList,
      required this.titleText,
      required this.buttonText,
      required this.buttonOnPress,
      required this.isTabletScreen,
      required this.bottomTitleText,
      required this.bottomLinkText,
      required this.destinationRoute,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isTabletScreen ? 171.w : 25.w,
        right: isTabletScreen ? 171.w : 25.w,
        top: isTabletScreen ? 0 : 20.h,
        bottom: isTabletScreen ? 45.h : 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: isTabletScreen
              ? [
                  BoxShadow(
                    color: AppColor.secondaryGrey.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 12,
                    offset: Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTabletScreen ? 50.w : 0,
            vertical: isTabletScreen ? 50.h : 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  titleText,
                  style: Theme.of(context).textTheme.bodyText2!,
                ),
              ),
              SizedBox(height: 30.h),
              ...textFieldList,
              CustomButton(
                  value: buttonText,
                  width: Device.screenWidth,
                  height: 50.h,
                  buttonOnPress: buttonOnPress),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  bottomTitleText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: AppColor.secondaryGrey),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, destinationRoute);
                  },
                  child: Text(
                    bottomLinkText,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.green, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
