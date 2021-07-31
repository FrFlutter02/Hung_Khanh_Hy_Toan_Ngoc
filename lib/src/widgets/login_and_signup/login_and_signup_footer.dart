import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/utils/screen_util.dart';

class LoginAndSignupFooter extends StatelessWidget {
  final String footerTitleText;
  final String footerLinkText;
  final String destinationRoute;

  const LoginAndSignupFooter(
      {required this.footerTitleText,
      required this.footerLinkText,
      required this.destinationRoute,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();

    return Container(
      child: Column(
        children: [
          SizedBox(height: _screenUtil.height(30)),
          Center(
            child: Text(
              footerTitleText,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: AppColor.secondaryGrey),
            ),
          ),
          SizedBox(height: _screenUtil.height(5)),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, destinationRoute);
              },
              child: Text(
                footerLinkText,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: AppColor.green, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
