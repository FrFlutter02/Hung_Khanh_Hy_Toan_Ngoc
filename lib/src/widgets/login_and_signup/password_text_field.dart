import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';

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
                    onTap: () {
                      Navigator.pushNamed(context, '/forgotPasswordScreen');
                    },
                    child: Text(
                      LoginScreenText.forgotPassword,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AppColor.primaryGrey,
                          ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
        SizedBox(height: 15.h),
        TextField(
          controller: widget.passwordController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 6.h),
            errorMaxLines: 2,
            errorText: widget.errorText.isEmpty ? null : widget.errorText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: LoginScreenColor.textFieldBottomBorder,
                width: 1.w,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.green,
                width: 1.w,
              ),
            ),
            isDense: true,
          ),
          style: Theme.of(context).textTheme.bodyText2!,
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
