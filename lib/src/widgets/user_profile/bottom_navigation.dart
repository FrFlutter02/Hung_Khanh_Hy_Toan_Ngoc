import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/constants/constant_text.dart';

import 'recipe_card.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil _screenUtil = ScreenUtil();

    late double BottomNavigationWidth;
    if (Device.get().isPhone) {
      BottomNavigationWidth = _screenUtil.width(375);
    } else {
      BottomNavigationWidth = _screenUtil.width(770);
    }
    return Container(
      width: BottomNavigationWidth,
      height: _screenUtil.height(90),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {},
            child: Container(
              height: _screenUtil.height(32),
              width: _screenUtil.width(32),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(UserProfileText.nav1))),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Container(
              height: _screenUtil.height(32),
              width: _screenUtil.width(32),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(UserProfileText.nav2))),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Container(
              height: _screenUtil.height(32),
              width: _screenUtil.width(32),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(UserProfileText.nav3))),
            ),
          )
        ],
      ),
    );
  }
}
