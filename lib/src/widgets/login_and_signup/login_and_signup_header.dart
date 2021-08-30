import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';
import '../../widgets/logo.dart';

class LoginAndSignupHeader extends StatelessWidget {
  final bool isTabletScreen;
  final String loginAndSignupHeaderTitle;
  const LoginAndSignupHeader(
      {required this.isTabletScreen,
      required this.loginAndSignupHeaderTitle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 25.w,
        right: 25.w,
        top: isTabletScreen ? 80.h : 60.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
        ),
        image: isTabletScreen
            ? null
            : DecorationImage(
                alignment: Alignment(0, -0.8.h),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstOut),
                image: AssetImage('assets/images/login-signup-background.jpeg'),
              ),
      ),
      width: Device.screenWidth,
      height: isTabletScreen ? 305.h : 285.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: isTabletScreen
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Logo(),
          SizedBox(
            height: isTabletScreen ? 130.h : 45.h,
          ),
          Text(
            loginAndSignupHeaderTitle,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AppColor.primaryBlack,
                  fontFamily: "Nunito-Bold",
                ),
          ),
        ],
      ),
    );
  }
}
