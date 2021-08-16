import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/widgets/user_profile/bottom_navigation.dart';

import '../../widgets/user_profile/user_information.dart';
import '../../widgets/user_profile/main_card.dart';
import '../../widgets/user_profile/recipe_card.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../../utils/screen_util.dart';

ScreenUtil _screenUtil = ScreenUtil();

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
                    height: _screenUtil.height(49),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 25),
                        child: Text(
                          UserProfileText.title,
                          style: TextStyle(
                            color: AppColor.primaryBlack,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: _screenUtil.width(124)),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: _screenUtil.height(20),
                                width: _screenUtil.width(20),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage(UserProfileText.icon))),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  UserProfileText.iconText,
                                  style: TextStyle(
                                      color: AppColor.green, fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: _screenUtil.height(30),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: _screenUtil.width(25)),
                      child: UserInformation(
                        isMyProfile: true,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: AppColor.primaryWhite)))),
                  SizedBox(
                    height: _screenUtil.height(25),
                  ),
                  MainCard(
                    isMyProfile: true,
                  )
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
                  SizedBox(
                    height: _screenUtil.width(80),
                  ),
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
                                  EdgeInsets.only(left: _screenUtil.width(25)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: _screenUtil.height(32),
                                    width: _screenUtil.width(32),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                UserProfileText.backIcon))),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      UserProfileText.back,
                                      style: TextStyle(
                                          color: AppColor.primaryBlack,
                                          fontSize: 16),
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
                      margin: EdgeInsets.only(left: _screenUtil.width(25)),
                      child: UserInformation(
                        isMyProfile: true,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: AppColor.primaryWhite)))),
                  SizedBox(
                    height: _screenUtil.height(25),
                  ),
                  MainCard(
                    isMyProfile: true,
                  )
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
