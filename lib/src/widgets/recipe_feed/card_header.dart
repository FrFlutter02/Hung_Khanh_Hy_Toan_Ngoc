import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';

class CardHeader extends StatelessWidget {
  final String avatar;
  final String fullName;
  final String time;

  const CardHeader(
      {Key? key,
      required this.avatar,
      required this.fullName,
      required this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundImage: NetworkImage(avatar),
        ),
        SizedBox(width: 10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: AppColor.primaryBlack,
                  fontSize: 12.sp,
                  fontFamily: 'Nunito-Bold'),
            ),
            Text(
              '${time}h ago',
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: RecipeFeedColor.subtitleCardHeader, fontSize: 12.sp),
            ),
          ],
        ),
      ],
    );
  }
}
