import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/constant_text.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo_icon.png'),
        SizedBox(width: 10.w),
        Text(AppText.iconText,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontFamily: "Nunito-Bold")),
      ],
    );
  }
}
