import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

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
    ScreenUtil _screenUtil = ScreenUtil();
    late double MainCardWidth;
    late double MainCardHeight;
    late double buttonWidth;
    if (Device.get().isPhone) {
      MainCardWidth = _screenUtil.width(325);
      MainCardHeight = _screenUtil.height(80);

      if (isMyProfile == true) {
        buttonWidth = _screenUtil.width(84);
      } else {
        buttonWidth = _screenUtil.width(149);
      }
    } else {
      MainCardWidth = _screenUtil.width(718);
      MainCardHeight = _screenUtil.height(80);
      if (isMyProfile == true) {
        buttonWidth = _screenUtil.width(186);
      } else {
        buttonWidth = _screenUtil.width(350);
      }
    }
    if (isMyProfile == true) {
      return Container(
        height: MainCardHeight,
        width: MainCardWidth,
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Container(
                      width: buttonWidth,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: AppColor.green,
                      ))),
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
                  ),
                ),
                Opacity(
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
                ),
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
    } else {
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
                      width: buttonWidth,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: AppColor.green,
                      ))),
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
                  ),
                ),
                Opacity(
                  opacity: 0.4,
                  child: Container(
                    width: buttonWidth,
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
}
