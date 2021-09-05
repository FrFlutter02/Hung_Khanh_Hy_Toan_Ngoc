import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String icons;
  final void Function() onTap;

  const CustomIconButton({Key? key, required this.icons, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(icons),
    );
  }
}
