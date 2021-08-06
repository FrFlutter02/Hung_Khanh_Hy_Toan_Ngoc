import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../blocs/signup_bloc/signup_bloc.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';
import '../custom_button.dart';

class LoginAndSignupBody extends StatelessWidget {
  final SignupBloc? signupBloc;
  final List<Widget> textFormFieldList;
  final String titleText;
  final String buttonText;
  final void Function() buttonOnPress;
  final String bottomTitleText;
  final String bottomLinkText;
  final String destinationRoute;
  final bool isTabletScreen;

  const LoginAndSignupBody(
      {this.signupBloc,
      required this.textFormFieldList,
      required this.titleText,
      required this.buttonText,
      required this.buttonOnPress,
      required this.isTabletScreen,
      required this.bottomTitleText,
      required this.bottomLinkText,
      required this.destinationRoute,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();
    return Padding(
      padding: EdgeInsets.only(
          left: _screenUtil.width(isTabletScreen ? 171 : 25),
          right: _screenUtil.width(isTabletScreen ? 171 : 25),
          top: isTabletScreen ? 0 : _screenUtil.height(20),
          bottom: isTabletScreen ? _screenUtil.height(45) : 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: isTabletScreen
              ? [
                  BoxShadow(
                    color: AppColor.secondaryGrey.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 12,
                    offset: Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTabletScreen ? _screenUtil.width(50) : 0,
            vertical: isTabletScreen ? _screenUtil.height(50) : 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: Theme.of(context).textTheme.bodyText2!,
              ),
              SizedBox(height: _screenUtil.height(30)),
              ...textFormFieldList,
              CustomButton(
                  signupBloc: signupBloc,
                  value: buttonText,
                  width: Device.screenWidth,
                  height: _screenUtil.height(50),
                  buttonOnPress: buttonOnPress),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: _screenUtil.height(30)),
                    Center(
                      child: Text(
                        bottomTitleText,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: AppColor.secondaryGrey),
                      ),
                    ),
                    SizedBox(height: _screenUtil.height(5)),
                    Center(
                      child: InkWell(
                        key: Key('bottomLink'),
                        onTap: () {
                          Navigator.pushNamed(context, destinationRoute);
                        },
                        child: Text(
                          bottomLinkText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: AppColor.green,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
