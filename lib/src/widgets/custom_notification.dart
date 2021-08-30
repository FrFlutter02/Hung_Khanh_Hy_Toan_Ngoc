import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_icon_button.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        CustomIconButton(
          icons: 'assets/images/icons/notifications.png',
          onTap: () {},
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.h),
          child: CustomIconButton(
            icons: 'assets/images/icons/messages.png',
            onTap: () {},
          ),
        ),
        CircleAvatar(
          radius: 18.r,
          backgroundImage: AssetImage('assets/images/quack.jpg'),
        ),
      ],
    );
  }
}
