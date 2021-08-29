import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/widgets/recipe_feed/card_header.dart';
import 'package:mockito/mockito.dart';

import '../../../cloud_firestore_mock.dart';

class MockPostServices extends Mock implements PostServices {}

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });
  setUpAll(() => HttpOverrides.global = null);
  final widget = ScreenUtilInit(
      builder: () => MaterialApp(
            home: Scaffold(
                body: CardHeader(
              avatar:
                  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
              fullName: '',
              time: 6,
            )),
          ));
  testWidgets('Should render Avatar widgets', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    expect(find.byType(CircleAvatar), findsOneWidget);
  });
  testWidgets('Should render text fullname, time widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    final Text text1 = tester.firstWidget(find.byType(Text));
    expect(text1.overflow, TextOverflow.ellipsis);
  });
}
