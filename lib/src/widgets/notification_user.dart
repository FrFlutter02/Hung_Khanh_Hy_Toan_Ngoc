import 'package:flutter/material.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../utils/screen_util.dart';
import '../widgets/icon_button_custom.dart';

class NotificationUser extends StatelessWidget {
  String avatar;
  ScreenUtil _screenUtil = ScreenUtil();
  NotificationUser({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _screenUtil.height(80),
      width: _screenUtil.width(768),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.primaryWhite))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: _screenUtil.height(32),
            width: _screenUtil.width(82),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(UserProfileText.searchIcon))),
          ),
          Container(
            height: _screenUtil.height(32),
            width: _screenUtil.width(102),
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(UserProfileText.logo))),
          ),
          Container(
            width: _screenUtil.width(169),
            height: _screenUtil.height(80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButtonCustom(
                  icons: 'assets/images/icons/notifications.png',
                  onTap: () {},
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: _screenUtil.width(25)),
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
