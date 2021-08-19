import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

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

ScreenUtil _screenUtil = ScreenUtil();
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
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _screenUtil.height(49),
                  ),
                  Container(
                    width: _screenUtil.width(325),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: _screenUtil.width(129),
                          child: TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: _screenUtil.width(15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: _screenUtil.height(32),
                                          width: _screenUtil.width(20),
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
                            height: _screenUtil.height(32),
                            width: _screenUtil.width(20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        UserProfileText.moreOption))))
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: _screenUtil.width(25)),
                      width: _screenUtil.width(315),
                      height: _screenUtil.height(163),
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
                            height: _screenUtil.height(10),
                          ),
                          Container(
                            child: CustomButton(
                                width: _screenUtil.width(315),
                                height: _screenUtil.height(50),
                                value: "Follow",
                                buttonOnPress: () {}),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: AppColor.primaryWhite)))),
                  SizedBox(
                    height: _screenUtil.height(13),
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
                    top: MediaQuery.of(context).size.height -
                        _screenUtil.height(90)),
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
                    height: _screenUtil.height(24),
                  ),
                  NotificationUser(avatar: userData[0].avatar),
                  SizedBox(
                    height: _screenUtil.height(25),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: _screenUtil.width(5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      children: [
                                        Container(
                                          height: _screenUtil.height(32),
                                          width: _screenUtil.width(20),
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
                          padding: EdgeInsets.only(right: 25),
                          child: TextButton(
                              onPressed: () {},
                              child: Container(
                                height: _screenUtil.height(24),
                                width: _screenUtil.width(24),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(UserProfileText.edit))),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    child: Stack(
                      children: [
                        Container(
                            margin:
                                EdgeInsets.only(left: _screenUtil.width(25)),
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
                              width: _screenUtil.width(156),
                              height: _screenUtil.height(50),
                              value: "Follow",
                              buttonOnPress: () {}),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _screenUtil.height(25),
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
                    top: MediaQuery.of(context).size.height -
                        _screenUtil.height(90)),
                child: BottomNavigation(),
              )
            ],
          ),
        ),
      );
    }
  }
}
