import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/models/post_model.dart';

void main() {
  test('Should return Post Model from json', () {
    final Post post = Post(
      recipeId: 'recipeId',
      userId: 'userId',
      description: 'description',
      likes: 0,
      comments: 0,
      name: 'name',
      backgroundImage: 'backgroundImage',
      time: 0,
    );

    expect(
        post,
        Post(
          recipeId: 'recipeId',
          userId: 'userId',
          description: 'description',
          likes: 0,
          comments: 0,
          name: 'name',
          backgroundImage: 'backgroundImage',
          time: 0,
        ));
  });
}
