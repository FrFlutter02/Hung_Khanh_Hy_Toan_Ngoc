import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height / 3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(120)),
                  color: Colors.green,
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/login-signup-background.jpeg'),
                      fit: BoxFit.cover),
                ),
              ),
              Text(
                'NunitoBoldItalic',
                style: TextStyle(
                  fontFamily: "NunitoBoldItalic",
                  fontSize: 30,
                  // fontWeight: FontWeight.normal,
                  color: AppColor.primaryBlack,
                ),
              ),
              Image.asset('assets/images/logo.png'),
            ],
          ),
        ),
      ),
    );
  }
}
