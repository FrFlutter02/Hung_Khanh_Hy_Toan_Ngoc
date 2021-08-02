import 'package:flutter/material.dart';

import '../constants/constant_text.dart';
import '../utils/screen_util.dart';

class Logo extends StatelessWidget {
  final double width;
  final double height;

  const Logo({required this.width, required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();

    return Container(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: _screenUtil.width(18),
            height: _screenUtil.height(26),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo_icon.png'))),
          ),
          SizedBox(width: _screenUtil.width(10)),
          Text(AppText.iconText,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontFamily: "Nunito-Bold")),
        ],
      ),
    );
  }
}
