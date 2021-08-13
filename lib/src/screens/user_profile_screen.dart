import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../widgets/user_profile/user_information.dart';
import '../widgets/user_profile/main_card.dart';
import '../widgets/user_profile/recipe_list.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../utils/screen_util.dart';

ScreenUtil _screenUtil = ScreenUtil();

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

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
                  UserInformation(),
                  SizedBox(
                    height: _screenUtil.height(25),
                  ),
                  MainCard()
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "")
          ],
        ),
      );
    } else {
      return Scaffold();
    }
  }
}
