import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_bloc.dart';
import 'package:mobile_app/src/models/post_model.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/screens/recipe_feed_screen.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/widgets/recipe_feed/card_content.dart';
import 'package:mobile_app/src/widgets/recipe_feed/card_header.dart';
import 'package:mobile_app/src/widgets/recipe_feed/recipe_card_mobile.dart';
import 'package:mockito/mockito.dart';

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
    designSize: Size(375, 812),
    builder: () => MaterialApp(
      home: Scaffold(
        body: RecipeCardMobile(
          post: postService.mockPost,
          user: userService.mockUser,
        ),
      ),
    ),
  );

  testWidgets('Should render Recipe CardHeader vs CardContent widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    expect(
        find.descendant(
            of: find.byType(Container), matching: find.byType(CardHeader)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(Container), matching: find.byType(CardContent)),
        findsOneWidget);
  });
}
