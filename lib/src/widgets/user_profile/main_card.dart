import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'recipe_list.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

class MainCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil _screenUtil = ScreenUtil();
    return Container(
      height: _screenUtil.height(475),
      width: _screenUtil.width(325),
      margin: EdgeInsets.only(left: _screenUtil.width(25)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: AppColor.green,
                    ))),
                    child: Column(
                      children: [
                        Text("20",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColor.primaryBlack,
                            )),
                        Text("Recipes",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColor.primaryBlack,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text("75",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.primaryBlack,
                          )),
                      Text("Saved",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.primaryBlack,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text("248",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.primaryBlack,
                          )),
                      Text("Following",
                          style: TextStyle(
                            fontSize: 20,
                            color: AppColor.primaryBlack,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.4),
                  itemBuilder: (context, index) => RecipeCard()))
        ],
      ),
    );
  }
}
