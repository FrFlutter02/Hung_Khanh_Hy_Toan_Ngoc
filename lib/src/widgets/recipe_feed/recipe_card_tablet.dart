import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';
import '../../models/post_model.dart';
import 'card_content.dart';
import 'card_header.dart';

class RecipeCardTablet extends StatelessWidget {
  final Post post;

  const RecipeCardTablet({
    Key? key,
    required this.post,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 0.h),
      decoration: boxDecorationStyle,
      child: Row(
        children: [
          Container(
            height: 240.h,
            width: 240.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(post.backgroundImage),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.45.w, top: 15.h),
                  child: CardHeader(
                    avatar:
                        'https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg',
                    fullName: 'fullName',
                    time: post.time,
                  ),
                ),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(14.45.w, 0.h, 14.55.w, 15.h),
                  child: CardContent(
                    isTablet: true,
                    title: post.name,
                    subtitle: post.description,
                    numberLikes: post.likes,
                    numberComments: post.comments,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
