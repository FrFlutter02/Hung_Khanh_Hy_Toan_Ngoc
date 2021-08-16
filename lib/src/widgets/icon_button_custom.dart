import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final String icons;
  final void Function() onTap;

  const IconButtonCustom({Key? key, required this.icons, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(icons),
    );
  }
}
