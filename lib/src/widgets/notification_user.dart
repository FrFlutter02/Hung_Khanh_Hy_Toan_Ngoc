import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../utils/screen_util.dart';
import '../widgets/icon_button_custom.dart';

class NotificationUser extends StatelessWidget {
  String avatar;

  NotificationUser({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 768.w,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.primaryWhite))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
              height: (32.h),
              width: (82.w),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(UserProfileText.searchIcon))),
            ),
            Container(
              height: (32.h),
              width: (118.w),
            )
          ]),
          Container(
            height: (32.h),
            width: (102.w),
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(UserProfileText.logo))),
          ),
          Container(
            width: 200.w,
            height: 80.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButtonCustom(
                  icons: 'assets/images/icons/notifications.png',
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: IconButtonCustom(
                    icons: 'assets/images/icons/messages.png',
                    onTap: () {},
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(avatar),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
