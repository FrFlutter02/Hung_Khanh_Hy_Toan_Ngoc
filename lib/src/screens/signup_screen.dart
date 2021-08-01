import 'package:flutter/material.dart';
import '../constants/constant_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  _SignupScreenState createState() => _SignupScreenState();
}

class _FullNameTextFormField extends StatefulWidget {
  final TextEditingController fullNameController;
  final String label;

  const _FullNameTextFormField(
      {Key? key, required this.label, required this.fullNameController})
      : super(key: key);

  @override
  _FullNameTextFormFieldState createState() => _FullNameTextFormFieldState();
}

class _FullNameTextFormFieldState extends State<_FullNameTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("signup"),
    );
  }
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: Text("Sign Up"),
        ));
  }
}
