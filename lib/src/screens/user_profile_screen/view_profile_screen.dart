import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../blocs/post_bloc/post_bloc.dart';
import '../../blocs/post_bloc/post_state.dart';
import '../../widgets/top_bar_tablet.dart';

import '../../repository/user_data.dart';
import '../../widgets/custom_button.dart';

import '../../widgets/user_profile/user_information.dart';
import '../../widgets/user_profile/main_card.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';

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
      appBar: isMobile
          ? PreferredSize(
              preferredSize: Size.fromHeight(0.h),
              child: Container(),
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(90.h),
              child:
                  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                if (state is PostLoadSuccess) {
                  return TopBarTablet(
                    avatar: state.users[0].avatar,
                  );
                } else {
                  return TopBarTablet(
                    avatar:
                        'https://s3.amazonaws.com/hoorayapp/emp-user-profile/default.jpg',
                  );
                }
              }),
            ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile
              ? SizedBox(
                  height: 18.h,
                )
              : SizedBox(
                  height: 25.h,
                ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Row(
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
                                    color: AppColor.primaryGrey, fontSize: 16),
                              )
                            ],
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
          isMobile
              ? SizedBox(
                  height: 25.h,
                )
              : SizedBox(
                  height: 32.h,
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
                  border: Border(bottom: BorderSide(color: AppColor.white)))),
          MainCard(
              isMyProfile: false,
              recipesNumber: userData[0].recipes,
              savedNumber: userData[0].saved,
              followingNumber: userData[0].following,
              image: userData[0].recipeImages),
        ],
      ),
    );
  }
}
