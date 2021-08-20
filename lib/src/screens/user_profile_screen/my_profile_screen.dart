import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/widgets/notification_user.dart';

import '../../models/user_model.dart';
import '../../repository/user_data.dart';
import '../../widgets/user_profile/bottom_navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/user_profile/user_information.dart';
import '../../widgets/user_profile/main_card.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../../utils/screen_util.dart';

List<MyProfileModel> userData = user_data
    .map((user) => MyProfileModel(
        name: user["name"],
        role: user["role"],
        socialMedia: user["social-media"],
        recipes: user["recipes"],
        recipeImages: user["recipes-images"],
        following: user["following"],
        avatar: user["avatar"],
        saved: user["saved"]))
    .toList();

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Device.get().isPhone) {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 49.h,
                  ),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          color: AppColor.green, fontSize: 16),
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
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 25.w),
                      width: 325.w,
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
                                        image: AssetImage(
                                            UserProfileText.editIcon)))))
                      ]),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: AppColor.primaryWhite)))),
                  SizedBox(
                    height: 25.h,
                  ),
                  MainCard(
                      isMyProfile: true,
                      recipesNumber: userData[0].recipes,
                      savedNumber: userData[0].saved,
                      followingNumber: userData[0].following,
                      image: userData[0].recipeImages)
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height - 90.h),
                child: BottomNavigation(),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  NotificationUser(avatar: userData[0].avatar),
                  SizedBox(
                    height: (25.h),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: (25.w)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Container(
                                          height: (32.h),
                                          width: (20.w),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      UserProfileText
                                                          .backIcon))),
                                        ),
                                        Text(
                                          UserProfileText.back,
                                          style: TextStyle(
                                              color: AppColor.grey,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                        Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: TextButton(
                              onPressed: () {},
                              child: Container(
                                height: (24.h),
                                width: (24.w),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(UserProfileText.edit))),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Container(
                      margin: EdgeInsets.only(left: (25.w)),
                      child: UserInformation(
                        isMyProfile: true,
                        avatar: userData[0].avatar,
                        name: userData[0].name,
                        follower: userData[0].socialMedia[0],
                        likes: userData[0].socialMedia[1],
                        role: userData[0].role,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: AppColor.primaryWhite)))),
                  SizedBox(
                    height: (25),
                  ),
                  MainCard(
                    isMyProfile: true,
                    recipesNumber: userData[0].recipes,
                    savedNumber: userData[0].saved,
                    followingNumber: userData[0].following,
                    image: userData[0].recipeImages,
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height - (90.h)),
                child: BottomNavigation(),
              )
            ],
          ),
        ),
      );
    }
  }
}
