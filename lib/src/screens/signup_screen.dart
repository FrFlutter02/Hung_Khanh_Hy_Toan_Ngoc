import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

import '../../src/utils/validator.dart';
import '../blocs/signup_bloc/signup_bloc.dart';
import '../blocs/signup_bloc/signup_event.dart';
import '../blocs/signup_bloc/signup_state.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../models/user_model.dart';
import '../utils/screen_util.dart';
import '../widgets/login_and_signup/email_text_form_field.dart';
import '../widgets/login_and_signup/login_and_signup_body.dart';
import '../widgets/login_and_signup/login_and_signup_header.dart';
import '../widgets/login_and_signup/password_text_form_field.dart';

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
  final ScreenUtil _screenUtil = ScreenUtil();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: AppColor.secondaryGrey),
          ),
        ),
        SizedBox(height: _screenUtil.height(15)),
        TextFormField(
          controller: widget.fullNameController,
          cursorColor: AppColor.green,
          enableSuggestions: false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 6),
            errorMaxLines: 2,
            errorText: context.read<SignupBloc>().state is SignupFailure &&
                    (context.read<SignupBloc>().state as SignupFailure)
                        .fullNameErrorMessage
                        .isNotEmpty
                ? (context.read<SignupBloc>().state as SignupFailure)
                    .fullNameErrorMessage
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: LoginScreenColor.textFieldBottomBorder,
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.green,
                width: 1,
              ),
            ),
            isDense: true,
          ),
          style: TextStyle(color: AppColor.primaryBlack),
        ),
        SizedBox(height: _screenUtil.height(30)),
      ],
    );
  }
}

class _SignupScreenState extends State<SignupScreen> {
  bool isTabletScreen = false;
  final TextEditingController fullNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            Navigator.of(context).pushNamed('/homeScreen');
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: isTabletScreen
                        ? DecorationImage(
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/images/login-signup-background.jpeg'),
                          )
                        : null),
              ),
              Container(
                height: Device.screenHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.white.withOpacity(0.2),
                      AppColor.white,
                    ],
                    stops: [0.0, 0.9],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    LoginAndSignupHeader(
                      isTabletScreen: isTabletScreen,
                      loginAndSignupHeaderTitle: isTabletScreen
                          ? SignupScreenText.startFromSratch
                          : SignupScreenText.startFromSratch
                              .replaceFirst(' ', '\n'),
                    ),
                    LoginAndSignupBody(
                      signupBloc: context.read<SignupBloc>(),
                      titleText: SignupScreenText.createAccountToContinue,
                      isTabletScreen: isTabletScreen,
                      textFormFieldList: [
                        _FullNameTextFormField(
                          label: SignupScreenText.fullNameLabel,
                          fullNameController: fullNameController,
                        ),
                        EmailTextFormField(
                            label: SignupScreenText.emailNameLabel,
                            emailController: emailController,
                            errorText: state is SignupFailure
                                ? state.emailErrorMessage
                                : ''),
                        PasswordTextFormField(
                          label: SignupScreenText.passwordLabel,
                          passwordController: passwordController,
                          errorText: state is SignupFailure
                              ? state.passwordErrorMessage
                              : '',
                        ),
                      ],
                      buttonText: SignupScreenText.signupButton,
                      buttonOnPress: () async {
                        final userModel = UserModel(
                            fullName: fullNameController.text,
                            email: emailController.text,
                            password: passwordController.text);
                        final signupRequested =
                            SignupRequested(userModel: userModel);
                        final errorList =
                            await _getErrorList(signupRequested, context);
                        if (errorList.isEmpty) {
                          context.read<SignupBloc>().add(signupRequested);
                        } else {
                          context.read<SignupBloc>().add(SignupErrorDetected(
                              fullNameErrorMessage: errorList[0],
                              emailErrorMessage: errorList[1],
                              passwordErrorMessage: errorList[2]));
                        }
                      },
                      bottomTitleText: SignupScreenText.alreadyHaveAnAccount,
                      bottomLinkText: SignupScreenText.loginHere,
                      destinationRoute: '/loginScreen',
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    if (Device.get().isTablet) {
      isTabletScreen = true;
    }
    super.initState();
  }

  Future<List<String>> _getErrorList(
      SignupRequested signupRequested, BuildContext context) async {
    String? fullNameErrorMessage =
        Validator.signupFullNameValidator(signupRequested);
    String? emailErrorMessage =
        await Validator.signupEmailValidator(signupRequested);
    String? passwordErrorMessage =
        Validator.signupPasswordValidator(signupRequested);

    if (fullNameErrorMessage.isNotEmpty ||
        emailErrorMessage.isNotEmpty ||
        passwordErrorMessage.isNotEmpty) {
      return [
        fullNameErrorMessage,
        emailErrorMessage,
        passwordErrorMessage,
      ];
    }
    return [];
  }
}
