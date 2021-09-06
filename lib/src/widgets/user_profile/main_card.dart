import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'list_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'recipe_card.dart';

class MainCard extends StatelessWidget {
  @override
  bool isMyProfile;
  String recipesNumber;
  String followingNumber;
  String savedNumber;
  List<String> image;
  MainCard(
      {required this.isMyProfile,
      required this.recipesNumber,
      required this.followingNumber,
      required this.savedNumber,
      required this.image});
  Widget build(BuildContext context) {
    late double MainCardWidth;
    late double MainCardHeight;

    if (Device.get().isPhone) {
      MainCardWidth = 325.w;
      MainCardHeight = 459.h;
      if (isMyProfile == false) {
        MainCardHeight = 425.h;
      }
    } else {
      MainCardWidth = 718.w;
      MainCardHeight = 610.h;
    }

    return Container(
      height: MainCardHeight,
      width: MainCardWidth,
      margin: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: AppColor.primaryWhite))),
            child: ListOption(
              isMyProfile: isMyProfile,
              recipes: recipesNumber,
              saved: savedNumber,
              following: followingNumber,
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: GridView.builder(
                itemCount: image.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1.4),
                itemBuilder: (context, index) => RecipeCard(
                      image: image[index],
                      title: "Foods",
                    )),
          ))
        ],
      ),
    );
  }
}
