import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/src/repository/user_data.dart';
import 'package:mobile_app/src/widgets/user_profile/user_information.dart';
import '../../../cloud_firestore_mock.dart';

main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final myProfileWidget = ScreenUtilInit(
      builder: () => MaterialApp(
            home: UserInformation(
              avatar: userData[0].avatar,
              follower: "5 followers",
              isMyProfile: true,
              likes: '24 likes',
              name: 'Tuan Ngoc',
              role: 'Master Chief',
            ),
          ));

  group("user information test testing", () {
    testWidgets("Should render correct name", (WidgetTester tester) async {
      await tester.pumpWidget(myProfileWidget);
      await tester.pumpAndSettle();
      final nameUser = find.text("Tuan Ngoc");
      expect(nameUser, findsOneWidget);
    });
    testWidgets("Should render correct role", (WidgetTester tester) async {
      await tester.pumpWidget(myProfileWidget);
      await tester.pumpAndSettle();
      final nameUser = find.text("Master Chief");
      expect(nameUser, findsOneWidget);
    });
  });
}
