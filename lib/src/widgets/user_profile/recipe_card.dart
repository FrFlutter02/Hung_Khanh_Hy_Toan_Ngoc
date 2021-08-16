import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

class RecipeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil _screenUtil = ScreenUtil();
    late double recipeCardWidth;
    late double recipeCardHeight;
    late double imageWidth;
    late double imageHeight;
    late double textWidth;
    late double textHeight;

    if (Device.get().isPhone) {
      recipeCardWidth = _screenUtil.width(155);
      recipeCardHeight = _screenUtil.width(132);
      imageWidth = _screenUtil.width(155);
      imageHeight = _screenUtil.height(100);
    } else if (Device.get().isTablet) {
      recipeCardWidth = _screenUtil.width(382);
      recipeCardHeight = _screenUtil.width(183);
      imageWidth = _screenUtil.width(382);
      imageHeight = _screenUtil.height(139);
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
                  color: Colors.amber),
              width: imageWidth,
              height: imageHeight,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Foods",
                style: TextStyle(fontSize: 16, color: AppColor.primaryBlack),
              ),
            )
          ],
        ),
      ),
    );
  }
}
