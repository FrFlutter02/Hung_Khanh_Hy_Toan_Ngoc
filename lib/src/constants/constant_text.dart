class AppText {
  static const String iconText = 'scratch';
  static const String fullNameErrorText = 'Fullname cannot be empty';
  static const String emailErrorText =
      'Please enter a valid email, e.g: john@gmail.com';
  static const String passwordErrorText =
      'Password must have as least 8 characters, including numbers, uppercase, lowercase characters and uncharacters';

  static RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
  static RegExp passwordRegex =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
}

class LoginScreenText {
  static const String welcome = "Welcome Back!";
  static const String pleaseLogin = "Please login to continue.";
  static const String emailLabel = "Email address";
  static const String passwordLabel = "Password";
  static const String forgotPassword = "Forgot password?";
  static const String loginButton = "Login";
  static const String newToScratch = "New to Scratch?";
  static const String createAccountHere = "Create account here";
}

class SignupScreenText {
  static const String startFromSratch = "Start from Scratch";
  static const String createAccountToContinue = "Create account to continue";
  static const String fullNameLabel = "Full Name";
  static const String emailNameLabel = "Email";
  static const String passwordLabel = "Password";
  static const String signupButton = "Create Account";
  static const String alreadyHaveAnAccount = "Already have an account?";
  static const String loginHere = 'Login Here';
}

class OnboardingTabletText {
  static const String firstTitle =
      'Join over 50 millions people sharing recipes everday';
  static const String secondTitle =
      'Never run out ideas again. Try new food, ingredients, cooking style, and more';
  static const String joinButton = 'Join Scratch';
  static const String learnMoreButton = 'Learn More';
}

class ForgotPasswordText {
  static const String title = "Reset password";
  static const String label =
      "Enter the email associated with your account and we'll send an email with a link to reset your password.";
  static const String sendButton = "Send";
  static const String tabletLabel = "Start from Scratch";
}
