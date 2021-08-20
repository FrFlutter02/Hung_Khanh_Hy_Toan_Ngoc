import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/repository/user_data.dart';
import 'package:mobile_app/src/screens/user_profile_screen/view_profile_screen.dart';
import 'package:mobile_app/src/widgets/custom_button.dart';
import 'package:mobile_app/src/widgets/user_profile/main_card.dart';
import 'package:mobile_app/src/widgets/user_profile/user_information.dart';

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

  final widget = MaterialApp(home: ViewProfileScreen());

  group("view profile screen test ", () {
    testWidgets('Should render user information widget ', (tester) async {
      await tester.pumpWidget(widget);
      final emailTextFormField = find.byType(UserInformation);
      expect(emailTextFormField, findsWidgets);
    });
    testWidgets("Should render back button in mobile ",
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final numberFollowing = find.text("Back");
      expect(numberFollowing, findsOneWidget);
    });
    testWidgets("Should render following button in mobile ",
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final textFollowing = find.text("Following");
      final customButton = find.byType(CustomButton);
      expect(textFollowing, findsOneWidget);
      expect(customButton, findsOneWidget);
    });
    testWidgets('Should render main card widget ', (tester) async {
      await tester.pumpWidget(widget);
      final emailTextFormField = find.byType(MainCard);
      expect(emailTextFormField, findsWidgets);
    });
  });
}
