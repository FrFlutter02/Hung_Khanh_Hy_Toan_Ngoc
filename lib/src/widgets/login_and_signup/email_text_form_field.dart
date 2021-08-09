import 'package:flutter/material.dart';

import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

class EmailTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController emailController;
  final String errorText;

  const EmailTextFormField({
    Key? key,
    required this.label,
    required this.emailController,
    required this.errorText,
  }) : super(key: key);

  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  final ScreenUtil _screenUtil = ScreenUtil();

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
        SizedBox(height: _screenUtil.height(15)),
        TextFormField(
          controller: widget.emailController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
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
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AppColor.primaryBlack),
        ),
        SizedBox(height: _screenUtil.height(30)),
      ],
    );
  }
}
