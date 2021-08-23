import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/user_model.dart';
import '../../repository/user_data.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/notification_user.dart';
import '../../widgets/user_profile/bottom_navigation.dart';
import '../../widgets/user_profile/user_information.dart';
import '../../widgets/user_profile/main_card.dart';
import '../../widgets/user_profile/recipe_card.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../../utils/screen_util.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late double screenWidth;

    late double followButtonWidth;
    late double userInformationWidth;
    late double userInformationHeight;
    double followButtonHeight = 50;
    bool isMobile;
    if (Device.get().isPhone) {
      isMobile = true;
      screenWidth = 325.w;
      followButtonWidth = 325.w;

      userInformationWidth = 400;
    } else {
      isMobile = false;
      screenWidth = 300.w;
      followButtonWidth = 161.w;
      userInformationWidth = 750.w;
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile
              ? SizedBox(
                  height: 55.h,
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    NotificationUser(avatar: userData[0].avatar),
                    SizedBox(height: 25)
                  ],
                ),
          Container(
            width: userInformationWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: (15).w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: (32.h),
                                  width: (20).w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              UserProfileText.backIcon))),
                                ),
                                Text(
                                  UserProfileText.back,
                                  style: TextStyle(
                                      color: AppColor.grey, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                TextButton(
                  onPressed: () {},
                  child: Container(
                      height: 32.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(UserProfileText.moreOption)))),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 25.w),
              child: isMobile
                  ? Column(
                      children: [
                        Container(
                          child: UserInformation(
                              isMyProfile: false,
                              avatar: userData[0].avatar,
                              name: userData[0].name,
                              follower: userData[0].socialMedia[0],
                              likes: userData[0].socialMedia[1],
                              role: userData[0].role),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          child: CustomButton(
                              width: followButtonWidth,
                              height: followButtonHeight,
                              value: "Follow",
                              buttonOnPress: () {}),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              child: UserInformation(
                                  isMyProfile: false,
                                  avatar: userData[0].avatar,
                                  name: userData[0].name,
                                  follower: userData[0].socialMedia[0],
                                  likes: userData[0].socialMedia[1],
                                  role: userData[0].role),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: CustomButton(
                                  width: followButtonWidth,
                                  height: followButtonHeight,
                                  value: "Follow",
                                  buttonOnPress: () {}),
                            )
                          ],
                        ),
                      ],
                    ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColor.primaryWhite)))),
          MainCard(
              isMyProfile: false,
              recipesNumber: userData[0].recipes,
              savedNumber: userData[0].saved,
              followingNumber: userData[0].following,
              image: userData[0].recipeImages)
        ],
      ),
    );
  }
}
