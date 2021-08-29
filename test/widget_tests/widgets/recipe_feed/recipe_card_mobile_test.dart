import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_bloc.dart';
import 'package:mobile_app/src/models/post_model.dart';
import 'package:mobile_app/src/screens/recipe_feed_screen.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/widgets/recipe_feed/card_content.dart';
import 'package:mobile_app/src/widgets/recipe_feed/card_header.dart';
import 'package:mobile_app/src/widgets/recipe_feed/recipe_card_mobile.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockPostServices extends Mock implements PostServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });
  setUpAll(() => HttpOverrides.global = null);
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
  final widget = ScreenUtilInit(
    designSize: Size(375, 812),
    builder: () => MaterialApp(
      home: Scaffold(
        body: RecipeCardMobile(
          post: mockPost,
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
