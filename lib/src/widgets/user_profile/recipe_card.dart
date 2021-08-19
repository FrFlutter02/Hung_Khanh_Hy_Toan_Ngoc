import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

class RecipeCard extends StatelessWidget {
  @override
  String image;
  RecipeCard({required this.image});
  Widget build(BuildContext context) {
    ScreenUtil _screenUtil = ScreenUtil();
    late double recipeCardWidth;
    late double recipeCardHeight;
    late double imageWidth;
    late double imageHeight;
    late double textWidth;
    late double textHeight;
    late double foodTitleSize;
    late double verticalPaddingTitle;
    if (Device.get().isPhone) {
      recipeCardWidth = _screenUtil.width(155);
      recipeCardHeight = _screenUtil.width(132);
      imageWidth = _screenUtil.width(155);
      imageHeight = _screenUtil.height(100);
      foodTitleSize = 16;
      verticalPaddingTitle = 0;
    } else if (Device.get().isTablet) {
      recipeCardWidth = _screenUtil.width(382);
      recipeCardHeight = _screenUtil.height(183);
      imageWidth = _screenUtil.width(382);
      imageHeight = _screenUtil.height(150);
      foodTitleSize = 22;
      verticalPaddingTitle = _screenUtil.height(15);
    }

    return Card(
      child: Container(
        width: _screenUtil.width(recipeCardWidth),
        height: _screenUtil.height(recipeCardHeight),
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
                  "Foods",
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
