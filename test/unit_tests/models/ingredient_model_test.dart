import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/ingredients_model.dart';

void main() {
  test('Should return RecipeModel from json', () {
    IngredientUpLoadModel a = IngredientUpLoadModel(
        id: '123', ingredient: 'ingredient', image: 'image');

    final result = a.toJson();
    expect(
        result, ({'id': '123', 'ingredient': 'ingredient', 'image': 'image'}));
  });
}
