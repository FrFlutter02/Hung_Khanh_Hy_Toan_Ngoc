import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/gallery_model.dart';

void main() {
  test('Should return RecipeModel from json', () {
    GalleryModel a = GalleryModel(id: '123', link: 'link');

    final result = a.toJson();
    expect(result, ({"id": '123', "url": 'link'}));
  });
}
