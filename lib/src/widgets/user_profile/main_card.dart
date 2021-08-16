import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/widgets/user_profile/list_options.dart';

import 'recipe_card.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

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
    ScreenUtil _screenUtil = ScreenUtil();
    late double MainCardWidth;
    late double MainCardHeight;
    late double buttonWidth;
    if (Device.get().isPhone) {
      MainCardWidth = _screenUtil.width(325);
      MainCardHeight = _screenUtil.height(460);
      buttonWidth = _screenUtil.width(84);
    } else {
      MainCardWidth = _screenUtil.width(718);
      MainCardHeight = _screenUtil.height(610);
      buttonWidth = _screenUtil.width(171);
    }

    return Container(
      height: MainCardHeight,
      width: MainCardWidth,
      margin: EdgeInsets.only(left: _screenUtil.width(25)),
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
                  itemCount: 6,
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
