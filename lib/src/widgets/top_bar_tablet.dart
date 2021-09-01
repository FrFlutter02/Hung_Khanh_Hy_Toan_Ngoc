import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';

import '../screens/search_screen.dart';
import '../widgets/icon_button_custom.dart';
import '../widgets/logo.dart';
import 'custom_notification.dart';

class TopBarTablet extends StatelessWidget {
  final String avatar;

  const TopBarTablet({Key? key, required this.avatar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      child: Wrap(
        children: [
          Stack(
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
                      onTap: () =>
                          Navigator.of(context).pushNamed('/searchScreen'),
                    ),
                    CustomNotification(
                      avatar: avatar,
                    ),
                  ],
                ),
              ),
              Logo(),
            ],
          ),
          Divider(
              height: 1.h, thickness: 2.h, color: RecipeFeedColor.dividerColor),
        ],
      ),
    );
  }
}
