class AppText {
  static const String iconText = 'scratch';

  static const String fullNameMustNotEmptyErrorText =
      'Fullname must not be empty';

  static const String emailInvalidErrorText =
      'Please enter a valid email, e.g: john@gmail.com';
  static const String emailAlreadyExistsErrorText = 'Email already exists';
  static const String emailDidNotExistErrorText = 'Email did not exist';
  static const String emailMustNotBeEmptyErrorText = 'Email must not be empty';

  static const String passwordErrorText =
      'Password must have as least 8 characters, including numbers, uppercase, lowercase characters and uncharacters';
  static const String passwordMustNotBeEmptyErrorText =
      'Password must not be empty';
  static const String passwordIsIncorrect = 'Password is incorrect';
}

class LoginScreenText {
  static const String welcome = "Welcome Back!";
  static const String pleaseLogin = "Please login to continue.";
  static const String emailLabel = "Email address";
  static const String passwordLabel = "Password";
  static const String forgotPassword = "Forgot password?";
  static const String loginButton = "Login";
  static const String newToScratch = "New to Scratch?";
  static const String createAccountHere = "Create Account Here";
}

class SignupScreenText {
  static const String startFromSratch = "Start from Scratch";
  static const String createAccountToContinue = "Create account to continue.";
  static const String fullNameLabel = "Full Name";
  static const String emailNameLabel = "Email";
  static const String passwordLabel = "Password";
  static const String signupButton = "Create Account";
  static const String alreadyHaveAnAccount = "Already have an account?";
  static const String loginHere = 'Login Here';

  static const String signupFailedErrorText = 'Signup failed';

  static RegExp emailRegex = RegExp(
      r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''');
  static RegExp passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
}

class OnboardingTabletText {
  static const String firstTitle =
      'Join over 50 millions people sharing recipes everday';
  static const String secondTitle =
      'Never run out ideas again. Try new foods, ingredients, cooking style, and more';
  static const String joinButton = 'Join Scratch';
  static const String learnMoreButton = 'Learn More';
}
