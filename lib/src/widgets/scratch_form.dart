import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/widgets/scratch_form_text_field.dart';

import '../blocs/signup_bloc/signup_bloc.dart';
import '../blocs/signup_bloc/signup_event.dart';
import '../blocs/signup_bloc/signup_state.dart';
import '../constants/constant_colors.dart' as colors;
import '../constants/constant_text.dart' as text;
import 'scratch_form_button.dart';

class ScratchForm extends StatelessWidget {
  final bool isTabletScreen;

  const ScratchForm({required this.isTabletScreen, Key? key}) : super(key: key);

  double getHeight(double designedPixel, double screenHeight) {
    return designedPixel / (isTabletScreen ? 1024 : 812) * screenHeight;
  }

  double getWidth(double designedPixel, double screenWidth) {
    return designedPixel / (isTabletScreen ? 768 : 375) * screenWidth;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: isTabletScreen ? 10 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTabletScreen ? getWidth(50, screenWidth) : 0,
          vertical: isTabletScreen ? getHeight(50, screenWidth) : 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text.SignupScreenText.createAccountToContinue,
              style: TextStyle(
                color: colors.AppColor.primaryGrey,
                fontFamily: 'Nunito-Regular',
                fontSize: 14,
              ),
            ),
            SizedBox(height: getHeight(47, screenHeight)),
            Text(
              text.SignupScreenText.fullNameLabel,
              style: TextStyle(
                  color: colors.AppColor.secondaryGrey,
                  fontFamily: 'Nunito-Regular',
                  fontSize: 14),
            ),
            SizedBox(
              height: getHeight(15, screenHeight),
            ),
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(bottom: getHeight(6, screenHeight)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: colors.LoginScreenColor.textFieldBottomBorder,
                  width: getWidth(1, screenWidth),
                )),
                isDense: true,
              ),
              style: TextStyle(color: colors.AppColor.primaryBlack),
            ),
            SizedBox(height: getHeight(30, screenHeight)),
            Text(
              text.SignupScreenText.emailNameLabel,
              style: TextStyle(
                  color: colors.AppColor.secondaryGrey,
                  fontFamily: 'Nunito-Regular',
                  fontSize: 14),
            ),
            SizedBox(
              height: getHeight(15, screenHeight),
            ),
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                return ScratchFormTextField(
                    bottomPadding: getHeight(6, screenHeight),
                    errorText: state.email.invalid ? 'Email is invalid' : '',
                    isEmail: true,
                    handleChanged: (value) => context
                        .read<SignupBloc>()
                        .add(SignupEmailChanged(email: value)));
              },
            ),
            SizedBox(height: getHeight(30, screenHeight)),
            Text(
              text.SignupScreenText.passwordLabel,
              style: TextStyle(
                  color: colors.AppColor.secondaryGrey,
                  fontFamily: 'Nunito-Regular',
                  fontSize: 14),
            ),
            SizedBox(
              height: getHeight(15, screenHeight),
            ),
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                return ScratchFormTextField(
                    bottomPadding: getHeight(6, screenHeight),
                    errorText: state.email.invalid
                        ? 'Password must have as least 8 characters, including uppercase, lowercase characters'
                        : '',
                    isPassword: true,
                    handleChanged: (value) => context
                        .read<SignupBloc>()
                        .add(SignupPasswordChanged(password: value)));
              },
            ),
            SizedBox(height: getHeight(30, screenHeight)),
            ScratchFormButton(
              width: screenWidth,
              height: getHeight(50, screenHeight),
              handlePressed: () {
                print("ha!");
              },
            ),
            SizedBox(height: getHeight(30, screenHeight)),
            Center(
              child: Text(text.SignupScreenText.alreadyHaveAnAccount,
                  style: TextStyle(
                    color: colors.AppColor.secondaryGrey,
                    fontFamily: 'Nunito-Regular',
                    fontSize: 14,
                  )),
            ),
            SizedBox(height: getHeight(5, screenHeight)),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/loginScreen');
                },
                child: Text(text.SignupScreenText.loginHere,
                    style: TextStyle(
                      color: colors.AppColor.green,
                      fontFamily: 'Nunito-Bold',
                      fontSize: 16,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
