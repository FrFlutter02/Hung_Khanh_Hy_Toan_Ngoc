import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_text.dart';
import 'recipe_card.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late double BottomNavigationWidth;
    if (Device.get().isPhone) {
      BottomNavigationWidth = 375.w;
    } else {
      BottomNavigationWidth = 770.w;
    }
    return Container(
      width: BottomNavigationWidth,
      height: 90.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {},
            child: Container(
              height: (32.h),
              width: (32.w),
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(UserProfileText.nav1))),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Container(
              height: 32.h,
              width: 32.w,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(UserProfileText.nav2))),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Container(
              height: 32.h,
              width: 32.w,
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
