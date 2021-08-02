import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../blocs/signup_bloc/signup_bloc.dart';
import '../../blocs/signup_bloc/signup_state.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';
import '../custom_button.dart';

class LoginAndSignupBody extends StatefulWidget {
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
  _LoginAndSignupBodyState createState() => _LoginAndSignupBodyState();
}

class _LoginAndSignupBodyState extends State<LoginAndSignupBody> {
  final ScreenUtil _screenUtil = ScreenUtil();
  bool isLoading = false;
  StreamSubscription? signupStreamSubscription;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Device.screenWidth,
      padding: EdgeInsets.only(
        left: _screenUtil.width(widget.isTabletScreen ? 171 : 25),
        right: _screenUtil.width(widget.isTabletScreen ? 171 : 25),
        top: widget.isTabletScreen ? 0 : _screenUtil.height(20),
        bottom: widget.isTabletScreen ? _screenUtil.height(45) : 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: widget.isTabletScreen
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
            horizontal: widget.isTabletScreen ? _screenUtil.width(50) : 0,
            vertical: widget.isTabletScreen ? _screenUtil.height(50) : 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.titleText,
                style: Theme.of(context).textTheme.bodyText2!,
              ),
              SizedBox(height: _screenUtil.height(30)),
              ...widget.textFormFieldList,
              CustomButton(
                  enabled: !isLoading,
                  value: widget.buttonText,
                  width: Device.screenWidth,
                  height: _screenUtil.height(50),
                  isLoading: isLoading,
                  buttonOnPress: widget.buttonOnPress),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: _screenUtil.height(30)),
                    Center(
                      child: Text(
                        widget.bottomTitleText,
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
                          Navigator.pushNamed(context, widget.destinationRoute);
                        },
                        child: Text(
                          widget.bottomLinkText,
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

  @override
  void dispose() {
    signupStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    signupStreamSubscription = widget.signupBloc?.stream.listen((signupState) {
      if (signupState is SignupInProgress) {
        setState(() {
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }
}
