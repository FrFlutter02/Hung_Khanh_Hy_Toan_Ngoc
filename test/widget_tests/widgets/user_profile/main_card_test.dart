import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/repository/user_data.dart';
import 'package:mobile_app/src/widgets/user_profile/list_options.dart';
import 'package:mobile_app/src/widgets/user_profile/main_card.dart';
import 'package:mobile_app/src/widgets/user_profile/recipe_card.dart';

import '../../../cloud_firestore_mock.dart';

main() {
  setUpAll(() async {
    setupCloudFirestoreMocks();
    await Firebase.initializeApp();
  });

  final widget = ScreenUtilInit(
      builder: () => MaterialApp(
          home: MainCard(
              isMyProfile: true,
              recipesNumber: "",
              followingNumber: "",
              savedNumber: "",
              image: userData[0].recipeImages)));
  group("user information test testing", () {
    testWidgets('Should render list option widget ', (tester) async {
      await tester.pumpWidget(widget);
      final emailTextFormField = find.byType(ListOption);
      expect(emailTextFormField, findsWidgets);
    });
    testWidgets('Should render recipes card list  widget ', (tester) async {
      await tester.pumpWidget(widget);
      final emailTextFormField = find.byType(RecipeCard);
      expect(emailTextFormField, findsWidgets);
    });
  });
}
