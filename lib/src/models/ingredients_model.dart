import 'dart:io';

class IngredientModel {
  final String id;
  final String ingredient;
  final File image;

  const IngredientModel({
    required this.id,
    required this.ingredient,
    required this.image,
  });
}

class IngredientUpLoadModel {
  final String id;
  final String ingredient;
  final String image;

  const IngredientUpLoadModel({
    required this.id,
    required this.ingredient,
    required this.image,
  });
}
