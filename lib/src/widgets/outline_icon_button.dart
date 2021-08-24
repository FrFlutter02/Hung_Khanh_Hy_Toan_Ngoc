import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineIconButton extends StatelessWidget {
  final String title;
  final String icons;
  final double radius;
  final Color color;

  const OutlineIconButton(
      {Key? key,
      required this.title,
      required this.icons,
      required this.radius,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(right: 11.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(6.w),
              child: Image.asset(icons),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: color, height: (18 / 14).h),
            )
          ],
        ),
      ),
    );
  }
}
