import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'recipe_card.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

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

    if (Device.get().isPhone) {
      MainCardWidth = 325.w;
      MainCardHeight = 116.h;

      if (isMyProfile == true) {
        buttonWidth = (90.w);
      } else {
        buttonWidth = (149.h);
      }
    } else {
      MainCardWidth = 718.w;
      MainCardHeight = (100.h);
      if (isMyProfile == true) {
        buttonWidth = (186.w);
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
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    child: TextButton(
                      onPressed: () {},
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
                                Text("Recipes",
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
              ),
              isMyProfile
                  ? Opacity(
                      opacity: 0.4,
                      child: Container(
                        width: buttonWidth,
                        child: TextButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Text(saved,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColor.primaryBlack,
                                  )),
                              Text("Saved",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.primaryBlack,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Container(
                width: buttonWidth,
                child: Opacity(
                  opacity: 0.4,
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      children: [
                        Text(following,
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColor.primaryBlack,
                            )),
                        Text("Following",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.primaryBlack,
                            )),
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
