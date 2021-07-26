import 'package:flutter/material.dart';

import '../constants/constant_colors.dart' as colors;

class ScratchFormTextField extends StatelessWidget {
  final double bottomPadding;

  final String errorText;
  final bool autoFocus;
  final bool isEmail;
  final bool isPassword;
  final void Function(String) handleChanged;

  const ScratchFormTextField(
      {required this.bottomPadding,
      required this.errorText,
      required this.handleChanged,
      this.autoFocus = false,
      this.isEmail = false,
      this.isPassword = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: handleChanged,
      autofocus: autoFocus,
      autocorrect: false,
      enableSuggestions: false,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      obscureText: isPassword,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: bottomPadding),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: colors.LoginScreenColor.textFieldBottomBorder,
              width: 1,
            ),
          ),
          errorText: errorText,
          isDense: true,
          errorMaxLines: 2),
      style: TextStyle(color: colors.AppColor.primaryBlack),
    );
  }
}
