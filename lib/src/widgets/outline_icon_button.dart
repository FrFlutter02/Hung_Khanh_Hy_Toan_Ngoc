import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineIconButton extends StatelessWidget {
  final String title;
  final String icons;

  const OutlineIconButton({Key? key, required this.title, required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(right: 11.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.green,
          ),
          borderRadius: BorderRadius.circular(4.r),
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
                  .bodyText1!
                  .copyWith(color: AppColor.green, height: (18 / 14).h),
            )
          ],
        ),
      ),
    );
  }
}
