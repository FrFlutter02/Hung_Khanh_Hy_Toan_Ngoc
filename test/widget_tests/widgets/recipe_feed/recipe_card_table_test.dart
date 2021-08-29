import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/post_model.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/widgets/recipe_feed/card_content.dart';
import 'package:mobile_app/src/widgets/recipe_feed/card_header.dart';
import 'package:mobile_app/src/widgets/recipe_feed/recipe_card_tablet.dart';

import '../../../cloud_firestore_mock.dart';

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
    HttpOverrides.global = null;
  });

  final mockPost = Post(
      backgroundImage:
          "https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg",
      comments: 1,
      likes: 1,
      name: 'hy',
      time: 111,
      recipeId: 'ádasd',
      userId: 'vip',
      description: 'hgildasgi');
  final mockUser = UserModel(
      fullName: '',
      avatar:
          'https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg',
      email: '');
  final widget = ScreenUtilInit(
    designSize: Size(768, 1024),
    builder: () => MaterialApp(
      home: Scaffold(
        body: RecipeCardTablet(
          post: mockPost,
          user: mockUser,
        ),
      ),
    ),
  );

  testWidgets('Should render CardHeader vs CardContent widgets',
      (WidgetTester tester) async {
    Device.screenWidth = 768;
    Device.screenHeight = 1200;
    Device.devicePixelRatio = 1;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    await tester.pumpWidget(widget);
    expect(
        find.descendant(
            of: find.byType(Padding), matching: find.byType(CardHeader)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(Padding), matching: find.byType(CardContent)),
        findsOneWidget);
  });
}
