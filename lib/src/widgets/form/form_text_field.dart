import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/constants/constant_text.dart';

class FormTextField extends StatelessWidget {
  final bool autocorrect;
  final bool isEmail;
  final bool isPassword;
  final bool forgotPasswordVisible;
  final TextEditingController controller;
  final String textFieldLabel;
  final String? Function(String?) validator;

  const FormTextField(
      {this.autocorrect = false,
      this.isEmail = false,
      this.isPassword = false,
      this.forgotPasswordVisible = false,
      required this.controller,
      required this.textFieldLabel,
      required this.validator,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textFieldLabel,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: AppColor.secondaryGrey,
                  ),
            ),
            forgotPasswordVisible
                ? Text(
                    LoginScreenText.forgotPassword,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: AppColor.primaryGrey,
                        ),
                  )
                : SizedBox.shrink()
          ],
        ),
        SizedBox(height: 15),
        TextFormField(
          validator: validator,
          autocorrect: autocorrect,
          controller: controller,
          enableSuggestions: false,
          keyboardType: isEmail ? TextInputType.emailAddress : null,
          obscureText: isPassword ? true : false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 6),
            errorMaxLines: 2,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: LoginScreenColor.textFieldBottomBorder,
                width: 1,
              ),
            ),
            isDense: true,
          ),
          style: TextStyle(color: AppColor.primaryBlack),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
