import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/widgets/notification_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../repository/user_data.dart';

import '../../widgets/user_profile/user_information.dart';
import '../../widgets/user_profile/main_card.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile;
    late double userProfileWidth;
    if (Device.get().isPhone) {
      isMobile = true;
      userProfileWidth = 325.w;
    } else {
      isMobile = false;
      userProfileWidth = 718.w;
    }
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMobile
                ? SizedBox(
                    height: 49.h,
                  )
                : SizedBox(
                    height: 24.h,
                  ),
            isMobile
                ? SizedBox.shrink()
                : NotificationUser(avatar: userData[0].avatar),
            isMobile
                ? SizedBox.shrink()
                : SizedBox(
                    height: 77.h,
                  ),
            isMobile
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 25.w),
                            child: Text(
                              UserProfileText.title,
                              style: TextStyle(
                                color: AppColor.primaryBlack,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 124.w),
                            child: Row(
                              children: [
                                Container(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20.h,
                                          width: 20.w,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      UserProfileText.icon))),
                                        ),
                                        Text(
                                          UserProfileText.iconText,
                                          style: TextStyle(
                                              color: AppColor.green,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      )
                    ],
                  )
                : SizedBox.shrink(),
            Container(
                margin: EdgeInsets.only(left: 25.w),
                width: userProfileWidth,
                child: Stack(children: [
                  UserInformation(
                      isMyProfile: true,
                      avatar: userData[0].avatar,
                      name: userData[0].name,
                      follower: userData[0].socialMedia[0],
                      likes: userData[0].socialMedia[1],
                      role: userData[0].role),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          height: 32.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage(UserProfileText.editIcon)))))
                ]),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: AppColor.primaryWhite)))),
            SizedBox(
              height: 25.h,
            ),
            MainCard(
                isMyProfile: true,
                recipesNumber: userData[0].recipes,
                savedNumber: userData[0].saved,
                followingNumber: userData[0].following,
                image: userData[0].recipeImages),
          ],
        ),
      ),
    );
  }
}
