import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/constants/constant_text.dart';

class TextFieldEmailCustom extends StatefulWidget {
  final String label;
  final TextEditingController emailController;
  const TextFieldEmailCustom(
      {Key? key, required this.label, required this.emailController})
      : super(key: key);

  @override
  _TextFieldEmailCustomState createState() => _TextFieldEmailCustomState();
}

class _TextFieldEmailCustomState extends State<TextFieldEmailCustom> {
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
                .subtitle1!
                .copyWith(color: AppColor.secondaryGrey),
          ),
        ),
        TextFormField(
          validator: (val) {
            return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val!)
                ? null
                : "Nhập vào Email";
          },
        ),
      ],
    );
  }
}

class TextFieldPasswordCustom extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const TextFieldPasswordCustom(
      {Key? key, required this.label, required this.controller})
      : super(key: key);

  @override
  _TextFieldPasswordCustomState createState() =>
      _TextFieldPasswordCustomState();
}

class _TextFieldPasswordCustomState extends State<TextFieldPasswordCustom> {
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
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: AppColor.secondaryGrey,
                      // fontFamily: "Nunito",
                    ),
              ),
            ),
            Text(
              LoginScreenText.forgotPassword,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: AppColor.primaryGrey,
                    // fontFamily: "Nunito",
                  ),
            )
          ],
        ),
        TextFormField(
          controller: widget.controller,
          validator: (val) {
            return val!.isEmpty || val.length < 8
                ? "Mật khẩu cần có ít nhất 8 kí tự"
                : null;
          },
        ),
      ],
    );
  }
}
