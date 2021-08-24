import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/icon_button_custom.dart';
import '../widgets/logo.dart';
import 'custom_notification.dart';

class TopBarTablet extends StatelessWidget {
  final void Function() onTap;

  const TopBarTablet({Key? key, required this.onTap}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButtonCustom(
                icons: 'assets/images/icons/search.png',
                onTap: onTap,
              ),
              CustomNotification(),
            ],
          ),
        ),
        Logo(),
      ],
    );
  }
}
