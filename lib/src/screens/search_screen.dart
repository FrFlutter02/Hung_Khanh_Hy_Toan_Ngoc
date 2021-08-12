import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/utils/screen_util.dart';
import 'package:mobile_app/src/widgets/search/search_box.dart';
import 'package:mobile_app/src/widgets/search/search_recipes.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(_screenUtil.width(25),
              _screenUtil.height(11), _screenUtil.width(25), 0),
          child: ListView(
            children: [
              SearchBox(),
              SizedBox(
                height: _screenUtil.height(24),
              ),
              SearchRecipes(),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: _screenUtil.height(343),
                  color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}
