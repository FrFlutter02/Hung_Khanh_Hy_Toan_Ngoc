import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/widgets/user_profile/list_options.dart';
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
    late double buttonWidth;
    if (Device.get().isPhone) {
      MainCardWidth = 325.w;
      if (isMyProfile == false) {
        MainCardHeight = 370.h;
      } else {
        MainCardHeight = 460.h;
      }

      buttonWidth = 84.w;
    } else {
      MainCardWidth = 718.w;
      MainCardHeight = 610.h;
      buttonWidth = 171.w;
    }

    return Container(
      height: MainCardHeight,
      width: MainCardWidth,
      margin: EdgeInsets.only(left: 25.w),
      child: Column(
        children: [
          ListOption(
            isMyProfile: isMyProfile,
            recipes: recipesNumber,
            saved: savedNumber,
            following: followingNumber,
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: image.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.4),
                  itemBuilder: (context, index) => RecipeCard(
                        image: image[index],
                      )))
        ],
      ),
    );
  }
}
