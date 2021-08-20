import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Device.get().isPhone) {
      return ScreenUtilInit(
          builder: () => Scaffold(
                body: Container(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: (30.h),
                          ),
                          Container(
                            width: (325.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (129.w),
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: (15).w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: (32.h),
                                                  width: (20).w,
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
                                          ),
                                        ],
                                      )),
                                ),
                                Container(
                                    height: 32.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                UserProfileText.moreOption))))
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 25.w),
                              width: 315.w,
                              height: 163.h,
                              child: Column(
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
                                        width: 315.w,
                                        height: 50.h,
                                        value: "Follow",
                                        buttonOnPress: () {}),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: AppColor.primaryWhite)))),
                          MainCard(
                              isMyProfile: false,
                              recipesNumber: userData[0].recipes,
                              savedNumber: userData[0].saved,
                              followingNumber: userData[0].following,
                              image: userData[0].recipeImages)
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height - (90)),
                        child: BottomNavigation(),
                      )
                    ],
                  ),
                ),
              ));
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
                    height: 25.h,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 25.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 32.h,
                                          width: 20.w,
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                        Padding(
                          padding: EdgeInsets.only(right: 25.w),
                          child: TextButton(
                              onPressed: () {},
                              child: Container(
                                height: 24.h,
                                width: 24.w,
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
                    child: Stack(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 25.w),
                            child: UserInformation(
                                isMyProfile: false,
                                avatar: userData[0].avatar,
                                name: userData[0].name,
                                follower: userData[0].socialMedia[0],
                                likes: userData[0].socialMedia[1],
                                role: userData[0].role),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColor.primaryWhite)))),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: CustomButton(
                              width: 156.w,
                              height: 50.h,
                              value: "Follow",
                              buttonOnPress: () {}),
                        )
                      ],
                    ),
                  ),
                  MainCard(
                      isMyProfile: false,
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
    }
  }
}
