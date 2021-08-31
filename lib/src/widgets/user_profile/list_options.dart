import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';

class ListOption extends StatelessWidget {
  bool isMyProfile;
  String recipes;
  String following;
  String saved;
  ListOption(
      {required this.isMyProfile,
      required this.following,
      required this.recipes,
      required this.saved});
  @override
  Widget build(BuildContext context) {
    late double MainCardWidth;
    late double MainCardHeight;
    late double buttonWidth;
    String savedButtonText = "Saved";
    String recipedButtonText = "Recipes";
    String followingButtonText = "Following";

    if (Device.get().isPhone) {
      MainCardWidth = 325.w;
      MainCardHeight = 116.h;

      if (isMyProfile == true) {
        buttonWidth = (80.w);
      } else {
        buttonWidth = (140.h);
      }
    } else {
      MainCardWidth = 718.w;
      MainCardHeight = (100.h);
      if (isMyProfile == true) {
        buttonWidth = 186.w;
      } else {
        buttonWidth = 320.w;
      }
    }
    return Container(
      height: MainCardHeight,
      width: MainCardWidth,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: TextButton(
                  onPressed: () {},
                  child: Opacity(
                    opacity: 1,
                    child: Stack(
                      children: [
                        Container(
                          width: buttonWidth,
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Column(
                            children: [
                              Text(recipes,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.primaryBlack,
                                  )),
                              Text(recipedButtonText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.primaryBlack,
                                  ))
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: buttonWidth,
                            height: 4,
                            decoration: BoxDecoration(
                                color: AppColor.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              isMyProfile
                  ? Container(
                      child: TextButton(
                        onPressed: () {},
                        child: Opacity(
                          opacity: 0.4,
                          child: Stack(
                            children: [
                              Container(
                                width: buttonWidth,
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Column(
                                  children: [
                                    Text(recipes,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: AppColor.primaryBlack,
                                        )),
                                    Text(savedButtonText,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.primaryBlack,
                                        ))
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: buttonWidth,
                                  height: 4,
                                  decoration: BoxDecoration(
                                      color: null,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8))),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                child: TextButton(
                  onPressed: () {},
                  child: Opacity(
                    opacity: 0.4,
                    child: Stack(
                      children: [
                        Container(
                          width: buttonWidth,
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Column(
                            children: [
                              Text(recipes,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.primaryBlack,
                                  )),
                              Text(followingButtonText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.primaryBlack,
                                  ))
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: buttonWidth,
                            height: 4,
                            decoration: BoxDecoration(
                                color: null,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
