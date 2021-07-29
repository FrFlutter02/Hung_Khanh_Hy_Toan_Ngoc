import 'package:flutter/material.dart';

import '../constants/constant_colors.dart' as colors;
import '../constants/constant_text.dart' as text;

class CustomButton extends StatelessWidget {
  final bool enabled;
  final double width;
  final double height;
  final void Function() handlePressed;

  const CustomButton(
      {required this.enabled,
      required this.width,
      required this.height,
      required this.handlePressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? handlePressed : null,
        child: Text(
          text.SignupScreenText.createAccount,
          style: TextStyle(
            fontFamily: 'Nunito-Bold',
            fontSize: 16,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(colors.AppColor.green),
            foregroundColor: MaterialStateProperty.all(colors.AppColor.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            )),
      ),
    );
  }
}
