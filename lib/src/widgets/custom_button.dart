import 'dart:async';

import 'package:flutter/material.dart';
import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_bloc/login_state.dart';

import '../constants/constant_colors.dart';
import '../utils/screen_util.dart';

class CustomButton extends StatefulWidget {
  final LoginBloc? loginBloc;
  final double width;
  final double height;
  final String value;
  final void Function() buttonOnPress;

  const CustomButton(
      {required this.loginBloc,
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
  StreamSubscription? loginStreamSubscription;
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
    loginStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    loginStreamSubscription = widget.loginBloc?.stream.listen((loginState) {
      setState(() {
        if (loginState is LoginInProgress) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      });
    });
    super.initState();
  }
}
