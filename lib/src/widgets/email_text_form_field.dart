import 'package:flutter/material.dart';
import '../../src/constants/constant_colors.dart';
import '../../src/validator.dart';

class EmailTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController emailController;
  final bool isExist;
  const EmailTextFormField(
      {Key? key,
      required this.label,
      required this.emailController,
      this.isExist = false})
      : super(key: key);
// String checkEmailValidatorOrEmailExist(){
// if (!isExist) {

//   return
// } else {
//   return
// }
// }
  @override
  _EmailTextFormFieldState createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
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
        SizedBox(height: 15),
        TextFormField(
          validator: (value) => Validator.emailValidator(value!),
          controller: widget.emailController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 6),
            errorMaxLines: 2,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: LoginScreenColor.textFieldBottomBorder,
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.green,
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
