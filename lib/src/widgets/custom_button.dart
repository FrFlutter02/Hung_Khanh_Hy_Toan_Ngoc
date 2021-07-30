import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';

import '../constants/constant_colors.dart';

class CustomButton extends StatelessWidget {
  final bool enabled;
  final double width;
  final double height;
  final String value;
  final void Function() handlePressed;

  const CustomButton(
      {required this.enabled,
      required this.width,
      required this.height,
      required this.value,
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
          value,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AppColor.white),
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
