import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/src/screens/user_profile_screen/view_profile_screen.dart';
import 'package:mobile_app/src/widgets/custom_button.dart';
import 'package:mobile_app/src/widgets/logo.dart';

import 'package:mobile_app/src/widgets/user_profile/main_card.dart';
import 'package:mobile_app/src/widgets/user_profile/user_information.dart';

import '../../../cloud_firestore_mock.dart';

main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final mobileWidget = ScreenUtilInit(
      designSize: Size(375, 950),
      builder: () => MaterialApp(home: ViewProfileScreen()));

  final tabletWidget = ScreenUtilInit(
      designSize: Size(770, 1050),
      builder: () => MaterialApp(home: ViewProfileScreen()));
  group("view profile screen test ", () {
    testWidgets('Should render user information widget ', (tester) async {
      await tester.pumpWidget(mobileWidget);
      final emailTextFormField = find.byType(UserInformation);
      expect(emailTextFormField, findsWidgets);
    });
    testWidgets("Should render back button in mobile ",
        (WidgetTester tester) async {
      await tester.pumpWidget(mobileWidget);
      await tester.pumpAndSettle();
      final numberFollowing = find.text("Back");
      expect(numberFollowing, findsOneWidget);
    });
    testWidgets("Should render following button in mobile ",
        (WidgetTester tester) async {
      await tester.pumpWidget(mobileWidget);
      await tester.pumpAndSettle();
      final textFollowing = find.text("Following");
      final customButton = find.byType(CustomButton);
      expect(textFollowing, findsOneWidget);
      expect(customButton, findsOneWidget);
    });
    testWidgets('Should render main card widget ', (tester) async {
      await tester.pumpWidget(mobileWidget);
      final emailTextFormField = find.byType(MainCard);
      expect(emailTextFormField, findsWidgets);
    });
  });
  group('tablet test', () {
    testWidgets('Should render logo', (tester) async {
      Device.screenWidth = 770;
      Device.screenHeight = 1024;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(tabletWidget);
      final firstTitleFinder = find.byType(Logo);
      expect(firstTitleFinder, findsOneWidget);
    });
    testWidgets('Should render user information', (tester) async {
      Device.screenWidth = 770;
      Device.screenHeight = 1024;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(tabletWidget);
      final firstTitleFinder = find.byType(MainCard);
      expect(firstTitleFinder, findsOneWidget);
    });
    testWidgets('Should render following button', (tester) async {
      Device.screenWidth = 770;
      Device.screenHeight = 1024;
      Device.devicePixelRatio = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      await tester.pumpWidget(tabletWidget);
      final followingButton = find.descendant(
          matching: find.text("Follow"), of: find.byType(CustomButton));
      expect(followingButton, findsOneWidget);
    });
  });
}
