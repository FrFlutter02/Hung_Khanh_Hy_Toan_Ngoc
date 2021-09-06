import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_text.dart';
import '../../constants/constant_colors.dart';

class UserInformation extends StatelessWidget {
  bool isMyProfile;
  String avatar;
  String name;
  String follower;
  String likes;
  String role;
  UserInformation(
      {required this.isMyProfile,
      required this.name,
      required this.follower,
      required this.likes,
      required this.role,
      required this.avatar});
  @override
  Widget build(BuildContext context) {
    late double UserInformationWidth;
    late double UserInformationHeight;

    if (Device.get().isPhone) {
      UserInformationWidth = (325.w);

      if (isMyProfile) {
        UserInformationHeight = (108.h);
      } else {
        UserInformationHeight = (90.h);
      }
    } else {
      UserInformationWidth = (718.w);
      UserInformationHeight = (113.h);
    }
    return Container(
      width: UserInformationWidth,
      height: UserInformationHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              backgroundImage: AssetImage(avatar),
              radius: 41,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: (15.w)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: (5.h)),
                  width: (80.w),
                  child: Text(name,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.primaryBlack,
                      )),
                ),
                Text(role,
                    style:
                        TextStyle(fontSize: 14, color: AppColor.primaryGrey)),
                SizedBox(
                  height: (11.h),
                ),
                Row(
                  children: [
                    Text(
                      follower,
                      style:
                          TextStyle(color: AppColor.primaryGrey, fontSize: 14),
                    ),
                    Container(
                        width: (24.w),
                        height: (24.h),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(UserProfileText.dot)))),
                    Text(
                      likes,
                      style:
                          TextStyle(color: AppColor.primaryGrey, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(UserProfileText.edit))),
          )
        ],
      ),
    );
  }
}
