import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/blocs/scratch_form_bloc/scratch_form_bloc.dart';

import '../blocs/scratch_form_bloc/scratch_form_bloc.dart';
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
        child: BlocBuilder<ScratchFormBloc, ScratchFormState>(
          builder: (context, state) {
            return Column(
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
                TextFormField(
                  onChanged: (value) => context
                      .read<ScratchFormBloc>()
                      .add(SignupEmailChanged(email: value)),
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: getHeight(6, screenHeight)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colors.LoginScreenColor.textFieldBottomBorder,
                          width: 1,
                        ),
                      ),
                      errorText: state.email.invalid
                          ? text.AppText.emailErrorText
                          : null,
                      isDense: true,
                      errorMaxLines: 2),
                  style: TextStyle(color: colors.AppColor.primaryBlack),
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
                TextFormField(
                  onChanged: (value) => context
                      .read<ScratchFormBloc>()
                      .add(SignupPasswordChanged(password: value)),
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(bottom: getHeight(6, screenHeight)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: colors.LoginScreenColor.textFieldBottomBorder,
                          width: 1,
                        ),
                      ),
                      errorText: state.password.invalid
                          ? text.AppText.passwordErrorText
                          : null,
                      isDense: true,
                      errorMaxLines: 2),
                  style: TextStyle(color: colors.AppColor.primaryBlack),
                ),
                SizedBox(height: getHeight(30, screenHeight)),
                ScratchFormButton(
                  enabled: true,
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
            );
          },
        ),
      ),
    );
  }
}
