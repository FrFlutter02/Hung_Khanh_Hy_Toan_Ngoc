import 'package:flutter/material.dart';

import '../../constants/constant_colors.dart';
import '../../helper.dart';
import '../../validator.dart';

class EmailTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController emailController;

  const EmailTextFormField(
      {Key? key, required this.label, required this.emailController})
      : super(key: key);

  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  final Helper _helper = Helper();

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
        SizedBox(height: _helper.height(15)),
        TextFormField(
          validator: (value) => Validator.emailValidator(value!),
          controller: widget.emailController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: _helper.height(6)),
            errorMaxLines: 2,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: LoginScreenColor.textFieldBottomBorder,
                width: _helper.width(1),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.green,
                width: _helper.width(1),
              ),
            ),
            isDense: true,
          ),
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AppColor.primaryBlack),
        ),
        SizedBox(height: _helper.height(30)),
      ],
    );
  }
}
