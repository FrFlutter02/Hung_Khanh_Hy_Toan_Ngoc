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
