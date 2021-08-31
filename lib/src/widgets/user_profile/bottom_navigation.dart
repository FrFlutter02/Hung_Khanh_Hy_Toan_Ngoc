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
    int _selectedIndex = 1;
    if (Device.get().isPhone) {
      BottomNavigationWidth = 375.w;
    } else {
      BottomNavigationWidth = 770.w;
    }
    return Container(
        color: AppColor.white,
        height: 90.h,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(UserProfileText.searchIcon),
                  color:
                      _selectedIndex == 0 ? AppColor.green : AppColor.iconText,
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(UserProfileText.pagingIcon),
                  color:
                      _selectedIndex == 1 ? AppColor.green : AppColor.iconText,
                ),
                label: 'Recipe'),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage(UserProfileText.cookIcon),
                  color:
                      _selectedIndex == 2 ? AppColor.green : AppColor.iconText,
                ),
                label: 'User profile')
          ],
          currentIndex: _selectedIndex,
        ));
  }
}
