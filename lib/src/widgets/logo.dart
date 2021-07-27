import 'package:flutter/material.dart';

import '../constants/constant_colors.dart' as colors;
import '../constants/constant_text.dart' as text;

class Logo extends StatelessWidget {
  final double width;
  final double height;

  const Logo({required this.width, required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 18,
            height: 26,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo_icon.png'))),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text.AppText.iconText,
            style: TextStyle(
              color: colors.AppColor.iconText,
              fontFamily: 'Nunito-Bold',
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
