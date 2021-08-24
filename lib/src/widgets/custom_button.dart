import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String value;
  final void Function() buttonOnPress;

  const CustomButton(
      {required this.width,
      required this.height,
      required this.value,
      required this.buttonOnPress,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: buttonOnPress,
        child: Text(
          value,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: AppColor.white, fontFamily: 'Nunito-Bold'),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColor.green),
          foregroundColor: MaterialStateProperty.all(AppColor.white),
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
