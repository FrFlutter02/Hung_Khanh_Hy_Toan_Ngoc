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
import '../../../mock/mock_post_service.dart';
import '../../../mock/mock_user_service.dart';

void main() {
  final postService = MockPostServices();
  final userService = MockUserServices();
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
    HttpOverrides.global = null;
  });

  final widget = ScreenUtilInit(
    designSize: Size(760, 1024),
    builder: () => MaterialApp(
      home: Scaffold(
        body: RecipeCardTablet(
          post: postService.mockPost,
          user: userService.mockUser,
        ),
      ),
    ),
  );

  testWidgets('Should render CardHeader vs CardContent widgets',
      (WidgetTester tester) async {
    Device.screenWidth = 760;
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
