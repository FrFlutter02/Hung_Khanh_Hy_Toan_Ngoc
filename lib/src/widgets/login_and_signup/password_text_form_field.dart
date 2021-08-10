import 'package:flutter/material.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../../utils/screen_util.dart';

class PasswordTextField extends StatefulWidget {
  final bool forgotPasswordVisible;
  final String label;
  final TextEditingController passwordController;
  final String errorText;

  const PasswordTextField(
      {this.forgotPasswordVisible = false,
      required this.label,
      required this.passwordController,
      required this.errorText,
      Key? key})
      : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
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
                ? InkWell(
                    child: Text(
                      LoginScreenText.forgotPassword,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColor.primaryGrey,
                          ),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/homeScreen'),
                  )
                : SizedBox.shrink()
          ],
        ),
        SizedBox(height: _screenUtil.height(15)),
        TextField(
          controller: widget.passwordController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: _screenUtil.height(6)),
            errorMaxLines: 2,
            errorText: widget.errorText.isEmpty ? null : widget.errorText,
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
