import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/repository/user_data.dart';
import 'package:mobile_app/src/widgets/user_profile/recipe_card.dart';

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

  final widget =
      MaterialApp(home: RecipeCard(image: userData[0].recipeImages[0]));

  group("user information test testing", () {
    testWidgets("Should render correct title", (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
      final nameUser = find.text("Foods");
      expect(nameUser, findsOneWidget);
    });
    testWidgets('Should render image recipes', (WidgetTester tester) async {
      final Image imageWidget =
          Image.asset('assets/images/potato_recipes/8YBHgP0WrEo.jpg');
      assert(imageWidget.image is AssetImage);
      final AssetImage assetImage = imageWidget.image as AssetImage;
      expect(
          assetImage.keyName, 'assets/images/potato_recipes/8YBHgP0WrEo.jpg');
    });
  });
}
