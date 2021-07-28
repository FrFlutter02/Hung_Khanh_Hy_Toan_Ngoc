import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

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
    return Container(
      padding: EdgeInsets.only(
          left: 25, right: 25, top: isTabletScreen ? 80 : 60, bottom: 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
        image: isTabletScreen
            ? null
            : DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/login-signup-background.jpeg'),
              ),
      ),
      width: Device.screenWidth,
      height: isTabletScreen ? 305 : 285,
      child: Column(
        mainAxisAlignment: isTabletScreen
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        crossAxisAlignment: isTabletScreen
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Logo(
            width: 102,
            height: 28,
          ),
          SizedBox(height: 45),
          Text(
            isTabletScreen
                ? formHeaderTitle
                : formHeaderTitle.replaceFirst(' ', '\n'),
            style: TextStyle(
              color: AppColor.primaryBlack,
              fontFamily: 'Nunito-Bold',
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
