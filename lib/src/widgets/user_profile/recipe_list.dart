import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

class RecipeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil _screenUtil = ScreenUtil();
    return Card(
      child: Container(
        width: _screenUtil.width(155),
        height: _screenUtil.height(132),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  color: Colors.amber),
              width: _screenUtil.width(155),
              height: _screenUtil.height(100),
            ),
            Container(
              alignment: Alignment.center,
              width: _screenUtil.width(155),
              height: _screenUtil.height(32),
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
