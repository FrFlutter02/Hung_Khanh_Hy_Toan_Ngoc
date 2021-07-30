import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../blocs/login_bloc/login_bloc.dart';
import '../../blocs/signup_bloc/signup_bloc.dart';
import '../../ultis/helper.dart';

import '../../constants/constant_colors.dart';
import '../custom_button.dart';

class FormBody extends StatefulWidget {
  final SignupBloc? signupBloc;
  final LoginBloc? loginBloc;
  final List<Widget> textFormFieldList;
  final String titleText;
  final String footerTitleText;
  final String footerLinkText;
  final String buttonText;

  final void Function() buttonOnPress;
  final String destinationRoute;
  final bool isTabletScreen;

  const FormBody(
      {this.signupBloc,
      this.loginBloc,
      required this.textFormFieldList,
      required this.titleText,
      required this.footerTitleText,
      required this.footerLinkText,
      required this.buttonText,
      required this.buttonOnPress,
      required this.destinationRoute,
      required this.isTabletScreen,
      Key? key})
      : super(key: key);

  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  final _formKey = GlobalKey<FormState>();
  final ScreenUtil _screenUtil = ScreenUtil();

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
      child: Form(
        key: _formKey,
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
                  enabled: true,
                  value: widget.buttonText,
                  width: Device.screenWidth,
                  height: _screenUtil.height(50),
                  handlePressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.buttonOnPress();
                    }
                  },
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Center(
                        child: Text(
                          widget.footerTitleText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppColor.secondaryGrey),
                        ),
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/homeScreen');
                          },
                          child: Text(
                            widget.footerLinkText,
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
      ),
    );
  }
}
