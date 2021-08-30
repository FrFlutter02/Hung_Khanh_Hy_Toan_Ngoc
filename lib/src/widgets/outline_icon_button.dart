import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/constant_colors.dart';

class OutlineIconButton extends StatelessWidget {
  final String title;
  final String icons;
  final double height;
  final double width;
  final double radius;
  final Color color;
  final void Function() onTap;
  final bool showIcon;
  final bool showBorder;
  const OutlineIconButton({
    Key? key,
    required this.title,
    required this.icons,
    required this.height,
    required this.width,
    required this.radius,
    this.color = AppColor.green,
    required this.onTap,
    this.showIcon = true,
    this.showBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(left: 10.w),
        decoration: showBorder
            ? BoxDecoration(
                border: Border.all(
                  color: color,
                ),
                borderRadius: BorderRadius.circular(radius),
              )
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 6.w),
              child: Image.asset(icons),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: color,
                  height: (1.2).h,
                  fontFamily: 'Nunito-Bold',
                  letterSpacing: 0.4),
            )
          ],
        ),
      ),
    );
  }
}
