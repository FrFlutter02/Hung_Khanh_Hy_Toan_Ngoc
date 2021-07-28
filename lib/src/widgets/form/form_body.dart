import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../custom_button.dart';
import '../../helper.dart';

class FormBody extends StatefulWidget {
  final List<Widget> textFormFieldList;
  final String titleText;
  final String linkText;
  final bool isTabletScreen;

  const FormBody(
      {required this.isTabletScreen,
      required this.textFormFieldList,
      required this.titleText,
      required this.linkText,
      Key? key})
      : super(key: key);

  @override
  _ScratchFormState createState() => _ScratchFormState();
}

class _ScratchFormState extends State<FormBody> {
  final _formKey = GlobalKey<FormState>();
  final Helper _helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Device.screenWidth,
        padding: EdgeInsets.only(
          left: _helper.width(widget.isTabletScreen ? 171 : 25),
          right: _helper.width(widget.isTabletScreen ? 171 : 25),
          top: _helper.height(20),
          bottom: widget.isTabletScreen ? _helper.height(45) : 0,
        ),
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.secondaryGrey.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 12,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.isTabletScreen ? _helper.width(50) : 0,
                vertical: widget.isTabletScreen ? _helper.height(50) : 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SignupScreenText.createAccountToContinue,
                    style: TextStyle(
                      color: AppColor.primaryGrey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: _helper.height(30)),
                  ...widget.textFormFieldList,
                  CustomButton(
                    enabled: true,
                    width: Device.screenWidth,
                    height: _helper.height(50),
                    handlePressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('success')));
                      }
                    },
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Center(
                          child: Text(widget.titleText,
                              style: TextStyle(
                                color: AppColor.secondaryGrey,
                                fontSize: 14,
                              )),
                        ),
                        SizedBox(height: 5),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/loginScreen');
                            },
                            child: Text(widget.linkText,
                                style: TextStyle(
                                  color: AppColor.green,
                                  fontFamily: 'Nunito-Bold',
                                  fontSize: 16,
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
