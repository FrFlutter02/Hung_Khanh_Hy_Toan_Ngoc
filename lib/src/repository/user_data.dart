import 'package:mobile_app/src/models/user_model.dart';

const List user_data = [
  {
    "name": "Nick Evan",
    "role": "Potato Master",
    "social-media": ['284 follower', '23k likes'],
    "recipes": "8",
    "saved": "75",
    "following": "248",
    "avatar": "assets/images/potato_recipes/user_avatar.jpg",
    "recipes-images": [
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg",
      "assets/images/potato_recipes/A6DyhlsAXyM.jpg",
      "assets/images/potato_recipes/rucxJkblWt8.jpg",
      "assets/images/potato_recipes/Uf0aVyl5C70.jpg",
      "assets/images/potato_recipes/XNM9O4Kfy2o.jpg",
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg"
    ]
  },
  {
    "name": "Nick Evan",
    "role": "Potato Master",
    "social-media": ['284 follower', '23k likes'],
    "recipes": "8",
    "saved": "75",
    "following": "248",
    "avatar": "assets/images/potato_recipes/user_avatar.jpg",
    "recipes-images": [
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg",
      "assets/images/potato_recipes/A6DyhlsAXyM.jpg",
      "assets/images/potato_recipes/rucxJkblWt8.jpg",
      "assets/images/potato_recipes/Uf0aVyl5C70.jpg",
      "assets/images/potato_recipes/XNM9O4Kfy2o.jpg",
      "assets/images/potato_recipes/8YBHgP0WrEo.jpg"
    ]
  }
];
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
