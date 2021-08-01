import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';

import '../constants/constant_colors.dart';
import '../utils/screen_util.dart';

class CustomButton extends StatelessWidget {
  final bool enabled;
  final double width;
  final double height;
  final String value;
  final bool isLoading;
  final void Function() buttonOnPress;

  const CustomButton(
      {required this.enabled,
      required this.width,
      required this.height,
      required this.value,
      required this.isLoading,
      required this.buttonOnPress,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: enabled ? buttonOnPress : null,
        child: isLoading
            ? SizedBox(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.white)),
                width: _screenUtil.width(25),
                height: _screenUtil.height(25),
              )
            : Text(
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
