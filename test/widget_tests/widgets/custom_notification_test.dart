import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/custom_notification.dart';
import 'package:mobile_app/src/widgets/icon_button_custom.dart';
import '../../cloud_firestore_mock.dart';

void main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
    HttpOverrides.global = null;
  });
  final widget = ScreenUtilInit(
      builder: () => MaterialApp(
            home: Scaffold(
              body: CustomNotification(
                  avatar:
                      'https://media-cdn.laodong.vn/storage/newsportal/2020/5/15/805708/Mu-Ky-Quac-Lam-Tu-Lo-16.jpg?w=720&crop=auto&scale=both'),
            ),
          ));
  testWidgets('Should render Avatar widgets', (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    expect(find.byType(CircleAvatar), findsOneWidget);
  });
  testWidgets('Should render text 2 Icon button', (WidgetTester tester) async {
    await tester.pumpWidget(widget);
    expect(
        find.descendant(
            of: find.byType(Wrap), matching: find.byType(IconButtonCustom)),
        findsWidgets);
  });
}
