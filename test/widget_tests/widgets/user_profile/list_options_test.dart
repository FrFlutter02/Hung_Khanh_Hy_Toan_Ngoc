import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/repository/user_data.dart';
import 'package:mobile_app/src/widgets/user_profile/list_options.dart';

import '../../../cloud_firestore_mock.dart';

List<MyProfileModel> userData = user_data
    .map((user) => MyProfileModel(
        name: user["name"],
        role: user["role"],
        socialMedia: user["social-media"],
        recipes: user["recipes"],
        recipeImages: user["recipes-images"],
        following: user["following"],
        avatar: user["avatar"],
        saved: user["saved"]))
    .toList();
main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final myProfileWidget = ScreenUtilInit(
      builder: () => MaterialApp(
              home: MaterialApp(
                  home: ListOption(
            following: '100',
            isMyProfile: true,
            recipes: '90',
            saved: '80',
          ))));
  final viewProfileWidget = ScreenUtilInit(
      builder: () => MaterialApp(
              home: MaterialApp(
                  home: ListOption(
            following: '100',
            isMyProfile: false,
            recipes: '90',
            saved: '80',
          ))));
  group("myProfile list options test testing", () {
    testWidgets("Should render following numbers", (WidgetTester tester) async {
      await tester.pumpWidget(myProfileWidget);
      await tester.pumpAndSettle();
      final numberFollowing = find.text("100");
      expect(numberFollowing, findsOneWidget);
    });
    testWidgets("Should render recipes number", (WidgetTester tester) async {
      await tester.pumpWidget(myProfileWidget);
      await tester.pumpAndSettle();
      final numberFollowing = find.text("90");
      expect(numberFollowing, findsOneWidget);
    });
    testWidgets("Should render saved number", (WidgetTester tester) async {
      await tester.pumpWidget(myProfileWidget);
      await tester.pumpAndSettle();
      final numberFollowing = find.text("80");
      expect(numberFollowing, findsOneWidget);
    });
    testWidgets("Not render saved button in viewProfile",
        (WidgetTester tester) async {
      await tester.pumpWidget(viewProfileWidget);
      await tester.pumpAndSettle();
      final numberFollowing = find.text("saved");
      expect(numberFollowing, findsNothing);
    });
  });
}
