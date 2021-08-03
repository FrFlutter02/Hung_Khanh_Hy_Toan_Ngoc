import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';
import '../../widgets/logo.dart';

class LoginAndSignupHeader extends StatelessWidget {
  final bool isTabletScreen;
  final String formHeaderTitle;
  const LoginAndSignupHeader(
      {required this.isTabletScreen, required this.formHeaderTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();

    return Container(
      padding: EdgeInsets.only(
        left: _screenUtil.width(25),
        right: _screenUtil.width(25),
        top: isTabletScreen ? _screenUtil.height(80) : _screenUtil.height(60),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
        ),
        image: isTabletScreen
            ? null
            : DecorationImage(
                alignment: Alignment(0, _screenUtil.height(-0.8)),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstOut),
                image: AssetImage('assets/images/login-signup-background.jpeg'),
              ),
      ),
      width: Device.screenWidth,
      height:
          isTabletScreen ? _screenUtil.height(305) : _screenUtil.height(285),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: isTabletScreen
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Logo(),
          SizedBox(
            height: isTabletScreen
                ? _screenUtil.height(130)
                : _screenUtil.height(45),
          ),
          Text(
            formHeaderTitle,
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
