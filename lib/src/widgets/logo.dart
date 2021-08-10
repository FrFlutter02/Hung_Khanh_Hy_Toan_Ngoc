import 'package:flutter/material.dart';

import '../constants/constant_text.dart';
import '../utils/screen_util.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo_icon.png'),
        SizedBox(width: _screenUtil.width(10)),
        Text(AppText.iconText,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontFamily: "Nunito-Bold")),
      ],
    );
  }
}
