import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/icon_button_custom.dart';

class CustomNotification extends StatelessWidget {
  final bool isTablet;
  final String avatar;
  const CustomNotification(
      {Key? key, this.isTablet = true, required this.avatar})
      : super(key: key);

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
        isTablet
            ? CircleAvatar(
                radius: 18.r,
                backgroundImage: NetworkImage(avatar),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
