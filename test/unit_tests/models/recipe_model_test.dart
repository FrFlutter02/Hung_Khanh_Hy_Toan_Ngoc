import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/recipe_model.dart';

void main() {
  test('Should return RecipeModel from json', () {
    final result = RecipeModel.fromJson({
      'name': 'chicken',
    });
    expect(result, RecipeModel(name: 'chicken'));
  });
}
