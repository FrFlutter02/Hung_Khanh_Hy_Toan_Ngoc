import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
import 'package:mobile_app/src/widgets/login_and_signup/login_and_signup_header.dart';

import '../../../cloud_firestore_mock.dart';

void main() {
  group('widget login header', () {
    setUpAll(() async {
      setupCloudFirestoreMocks();
      await Firebase.initializeApp();
    });

    final widget = MaterialApp(
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: Scaffold(
          body: LoginAndSignupHeader(
            isTabletScreen: false,
            loginAndSignupHeaderTitle: 'Welcome Back!',
          ),
        ),
      ),
    );
    testWidgets('Should render logo and name', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      final titleLogo = find.text('scratch');
      final Image imageWidget = Image.asset(
        'assets/images/logo_icon.png',
      );
      assert(imageWidget.image is AssetImage);
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.keyName, 'assets/images/logo_icon.png');
      expect(titleLogo, findsOneWidget);
    });
    testWidgets('Should render title', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      final titleText = find.text('Welcome Back!');
      expect(titleText, findsOneWidget);
    });

    testWidgets('Should render image background moblie',
        (WidgetTester tester) async {
      final Image imageWidget = Image.asset(
        'assets/images/login-signup-background.jpeg',
        alignment: Alignment(0, -10.7),
      );
      assert(imageWidget.image is AssetImage);
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(assetImage.keyName, 'assets/images/login-signup-background.jpeg');
    });
  });
}
