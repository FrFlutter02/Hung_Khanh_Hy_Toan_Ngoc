import 'package:mobile_app/src/models/post_model.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mockito/mockito.dart';

class MockPostServices extends Mock implements PostServices {
  final mockPost = Post(
      backgroundImage:
          "https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg",
      comments: 1,
      likes: 1,
      name: 'hy',
      time: 111,
      recipeId: 'ádasd',
      userId: 'vip',
      description: 'hgildasgi');
  final mockPost2 = Post(
      backgroundImage:
          "https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg",
      comments: 1,
      likes: 1,
      name: 'hy',
      time: 111,
      recipeId: 'ádasd',
      userId: 'vip',
      description: 'hgildasgi');
  Future<List<Post>> getData() async {
    return [mockPost, mockPost2];
  }
}
