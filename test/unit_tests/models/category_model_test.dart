import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/category.dart';

void main() {
  test('Should return RecipeModel from json', () {
    final result = CategoryModel.fromJson({
      'categoryName': 'chicken',
      'totalRecipes': 1,
    });
    expect(result, CategoryModel(categoryName: 'chicken', totalRecipes: 1));
  });
}
