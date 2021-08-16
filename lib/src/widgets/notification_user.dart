import 'package:flutter/material.dart';
import '../widgets/icon_button_custom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationUser extends StatelessWidget {
  String avatar;
  NotificationUser({Key? key, required this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 169.w,
      height: 80.h,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
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
            radius: 18.r,
            backgroundImage: AssetImage(avatar),
          ),
        ],
      ),
    );
  }
}
