import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String value;
  final void Function() buttonOnPress;
  final Color backgroundColor;
  final Color foregroundColor;

  const CustomButton(
      {required this.width,
      required this.height,
      required this.value,
      required this.buttonOnPress,
      this.backgroundColor = AppColor.green,
      this.foregroundColor = AppColor.white,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: buttonOnPress,
        child: Text(
          value,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: foregroundColor),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}
