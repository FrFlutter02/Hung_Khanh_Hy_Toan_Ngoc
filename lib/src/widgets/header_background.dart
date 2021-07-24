import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_text.dart';

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          height: height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(99),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/login-signup-background.jpeg'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 60, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 30, child: Image.asset("assets/images/logo.png")),
              const SizedBox(height: 45),
              Text(
                LoginScreenText.welcome,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontFamily: "Nunito"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
