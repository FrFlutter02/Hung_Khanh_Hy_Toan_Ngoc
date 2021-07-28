import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';

class FormFooter extends StatelessWidget {
  final String titleText;
  final String linkText;

  const FormFooter({required this.linkText, required this.titleText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: Text(titleText,
                style: TextStyle(
                  color: AppColor.secondaryGrey,
                  fontFamily: 'Nunito-Regular',
                  fontSize: 14,
                )),
          ),
          SizedBox(height: 5),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/loginScreen');
              },
              child: Text(linkText,
                  style: TextStyle(
                    color: AppColor.green,
                    fontFamily: 'Nunito-Bold',
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
