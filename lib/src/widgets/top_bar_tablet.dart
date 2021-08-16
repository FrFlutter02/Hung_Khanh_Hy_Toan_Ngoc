import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/icon_button_custom.dart';
import '../widgets/logo.dart';

class TopBarTablet extends StatelessWidget {
  const TopBarTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 80.h,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 25.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButtonCustom(
                icons: 'assets/images/icons/search.png',
                onTap: () {},
              ),
              NotificationUser(),
            ],
          ),
        ),
        Logo(),
      ],
    );
  }
}

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
