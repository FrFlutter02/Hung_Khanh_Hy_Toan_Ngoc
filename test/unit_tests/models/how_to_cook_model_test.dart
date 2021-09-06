import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/how_to_cook_model.dart';

void main() {
  test('Should return RecipeModel from json', () {
    HowToCookModel a = HowToCookModel(
        id: '123', step: 1, textHowToCook: 'step1', duration: '3mins');

    final result = a.toJson();
    expect(result,
        ({'id': '123', 'step': '1', 'stepText': 'step1', 'duration': '3mins'}));
  });
}
