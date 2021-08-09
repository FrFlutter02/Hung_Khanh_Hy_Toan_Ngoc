import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_bloc.dart';
import 'package:mobile_app/src/blocs/signup_bloc/signup_state.dart';

import '../constants/constant_colors.dart';
import '../utils/screen_util.dart';

class CustomButton extends StatefulWidget {
  final SignupBloc? signupBloc;
  final double width;
  final double height;
  final String value;
  final void Function() buttonOnPress;

  const CustomButton(
      {required this.signupBloc,
      required this.width,
      required this.height,
      required this.value,
      required this.buttonOnPress,
      Key? key})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  StreamSubscription? signupStreamSubscription;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: !isLoading ? widget.buttonOnPress : null,
        child: isLoading
            ? SizedBox(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.white)),
                width: _screenUtil.width(25),
                height: _screenUtil.height(25),
              )
            : Text(
                widget.value,
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

  @override
  void dispose() {
    signupStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    signupStreamSubscription = widget.signupBloc?.stream.listen((signupState) {
      setState(() {
        if (signupState is SignupInProgress) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      });
    });
    super.initState();
  }
}
