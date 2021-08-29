import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';
import '../../models/post_model.dart';
import 'card_content.dart';
import 'card_header.dart';

class RecipeCardMobile extends StatelessWidget {
  final Post post;

  const RecipeCardMobile({
    Key? key,
    required this.post,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 195.w,
      decoration: boxDecorationStyle,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(post.backgroundImage),
                  ),
                ),
                width: Device.screenWidth,
                height: 396.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  color: AppColor.white.withOpacity(0.95),
                ),
                height: 62.h,
                padding: EdgeInsets.only(left: 15.w),
                child: CardHeader(
                  avatar:
                      'https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg',
                  fullName: 'John Kerry',
                  time: post.time,
                ),
              ),
            ],
          ),
          Container(
            height: 160.h,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: CardContent(
              isTablet: false,
              title: post.name,
              subtitle: post.description,
              numberLikes: post.likes,
              numberComments: post.comments,
            ),
          ),
        ],
      ),
    );
  }
}
