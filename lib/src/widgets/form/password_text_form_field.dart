import 'package:flutter/material.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../../utils/screen_util.dart';
import '../../utils/validator.dart';

class PasswordTextFormField extends StatefulWidget {
  final bool forgotPasswordVisible;
  final String label;
  final TextEditingController passwordController;

  const PasswordTextFormField(
      {this.forgotPasswordVisible = false,
      required this.label,
      required this.passwordController,
      Key? key})
      : super(key: key);

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                widget.label,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: AppColor.secondaryGrey,
                    ),
              ),
            ),
            widget.forgotPasswordVisible
                ? Text(
                    LoginScreenText.forgotPassword,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColor.primaryGrey,
                        ),
                  )
                : SizedBox.shrink()
          ],
        ),
        SizedBox(height: _screenUtil.height(15)),
        TextFormField(
          validator: (value) => Validator.passwordValidator(value!),
          controller: widget.passwordController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: _screenUtil.height(6)),
            errorMaxLines: 2,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: LoginScreenColor.textFieldBottomBorder,
                width: _screenUtil.width(1),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.green,
                width: _screenUtil.width(1),
              ),
            ),
            isDense: true,
          ),
          style: Theme.of(context).textTheme.bodyText2!,
        ),
        SizedBox(height: _screenUtil.height(30)),
      ],
    );
  }
}