import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/helper.dart';

import '../../constants/constant_colors.dart';
import '../../widgets/logo.dart';

class FormHeader extends StatelessWidget {
  final bool isTabletScreen;
  final String formHeaderTitle;
  const FormHeader(
      {required this.isTabletScreen, required this.formHeaderTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Helper _helper = Helper();

    return Container(
      padding: EdgeInsets.only(
        left: _helper.width(25),
        right: _helper.width(25),
        top: isTabletScreen ? _helper.height(80) : _helper.height(60),
        // bottom: _helper.height(36),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(100),
        ),
        image: isTabletScreen
            ? null
            : DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/login-signup-background.jpeg'),
              ),
      ),
      width: Device.screenWidth,
      height: isTabletScreen ? _helper.height(305) : _helper.height(285),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: isTabletScreen
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Logo(
            width: _helper.width(102),
            height: _helper.height(28),
          ),
          SizedBox(
            height: isTabletScreen ? _helper.height(130) : _helper.height(45),
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
