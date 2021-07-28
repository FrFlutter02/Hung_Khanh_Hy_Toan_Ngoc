import 'package:flutter/material.dart';

import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../custom_button.dart';
import '../../widgets/form/form_text_field.dart';

class FormBody extends StatefulWidget {
  final List<FormTextField> textFormFieldList;
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

  double getHeight(double designedPixel, double screenHeight) {
    return designedPixel / (widget.isTabletScreen ? 1024 : 812) * screenHeight;
  }

  double getWidth(double designedPixel, double screenWidth) {
    return designedPixel / (widget.isTabletScreen ? 768 : 375) * screenWidth;
  }

  dynamic formTextFieldListWidgets() {}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          left: getWidth(widget.isTabletScreen ? 171 : 25, screenWidth),
          right: getWidth(widget.isTabletScreen ? 171 : 25, screenWidth),
          top: getHeight(20, screenHeight),
          bottom: widget.isTabletScreen ? getHeight(45, screenHeight) : 0,
        ),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: widget.isTabletScreen ? 5 : 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    widget.isTabletScreen ? getWidth(50, screenWidth) : 0,
                vertical:
                    widget.isTabletScreen ? getHeight(50, screenWidth) : 0,
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
                  SizedBox(height: getHeight(30, screenHeight)),
                  ...widget.textFormFieldList,
                  CustomButton(
                    enabled: true,
                    width: screenWidth,
                    height: getHeight(50, screenHeight),
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
