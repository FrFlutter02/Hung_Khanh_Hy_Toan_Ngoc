import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_text.dart';
import '../../constants/constant_colors.dart';
import '../icon_button_custom.dart';
import '../outline_icon_button.dart';

class CardContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final int numberLikes;
  final int numberComments;
  final bool isTablet;
  const CardContent({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.numberLikes,
    required this.numberComments,
    this.isTablet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 18.sp,
                    fontFamily: 'Nunito-SemiBold',
                    height: (1.6).h),
              ),
            ),
            IconButtonCustom(
              icons: 'assets/images/icons/like.png',
              onTap: () {},
            )
          ],
        ),
        isTablet ? SizedBox(height: 0.h) : SizedBox(height: 10.h),
        SizedBox(
          height: isTablet ? 75.h : 40.h,
          child: Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.visible,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: AppColor.secondaryGrey,
                height: (1.5).h,
                fontSize: 14.sp),
          ),
        ),
        isTablet ? SizedBox(height: 30.h) : SizedBox(height: 18.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    '$numberLikes ${RecipeFeedText.likes}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColor.primaryGrey, fontSize: 14.sp),
                  ),
                  Image.asset('assets/images/icons/dot.png'),
                  Text(
                    '$numberComments ${RecipeFeedText.comments}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColor.primaryGrey, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            OutlineIconButton(
              icons: 'assets/images/icons/add.png',
              title: RecipeFeedText.save,
              radius: 4.r,
              color: AppColor.green,
            ),
          ],
        ),
      ],
    );
  }
}
