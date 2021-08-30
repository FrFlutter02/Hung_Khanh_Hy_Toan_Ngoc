import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';

class EmailTextField extends StatefulWidget {
  final String label;
  final TextEditingController emailController;
  final String errorText;

  const EmailTextField({
    Key? key,
    required this.label,
    required this.emailController,
    required this.errorText,
  }) : super(key: key);

  @override
  _EmailTextFieldState createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: AppColor.secondaryGrey),
          ),
        ),
        SizedBox(height: 15.h),
        TextField(
          controller: widget.emailController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
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
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AppColor.primaryBlack),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
