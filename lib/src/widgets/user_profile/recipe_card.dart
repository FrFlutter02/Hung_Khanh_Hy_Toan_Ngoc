import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';

class RecipeCard extends StatelessWidget {
  @override
  String image;
  String title;
  RecipeCard({required this.image, required this.title});
  Widget build(BuildContext context) {
    late double recipeCardWidth;
    late double recipeCardHeight;
    late double imageWidth;
    late double imageHeight;
    late double textWidth;
    late double textHeight;
    late double foodTitleSize;
    late double verticalPaddingTitle;
    if (Device.get().isPhone) {
      recipeCardWidth = (155.w);
      recipeCardHeight = 129.h;
      imageWidth = 155.w;
      imageHeight = 85.h;
      foodTitleSize = 16;
      verticalPaddingTitle = 0;
    } else if (Device.get().isTablet) {
      recipeCardWidth = 382.w;
      recipeCardHeight = 183.h;
      imageWidth = 382.w;
      imageHeight = 150.h;
      foodTitleSize = 22;
      verticalPaddingTitle = 15.h;
    }

    return Card(
      child: Container(
        width: recipeCardWidth,
        height: recipeCardHeight,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill)),
              width: imageWidth,
              height: imageHeight,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: verticalPaddingTitle),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: foodTitleSize, color: AppColor.primaryBlack),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
