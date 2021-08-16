import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/icon_button_custom.dart';

class NotificationUser extends StatelessWidget {
  const NotificationUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
          backgroundImage: AssetImage('assets/users/user0.png'),
        ),
      ],
    );
  }
}
