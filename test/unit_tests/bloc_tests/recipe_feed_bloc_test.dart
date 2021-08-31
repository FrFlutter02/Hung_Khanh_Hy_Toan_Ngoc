import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_bloc.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_event.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_state.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
import 'package:mobile_app/src/models/post_model.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cloud_firestore_mock.dart';

class MockPostService extends Mock implements PostServices {
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

class MockUserService extends Mock implements UserServices {
  final mockUser = UserModel(
      fullName: '',
      avatar:
          'https://img.hoidap247.com/picture/question/20200718/large_1595063159202.jpg',
      email: '');
  Future<List<UserModel>> getUserData(String email) async {
    return [mockUser];
  }
}

class MockPostServiceEmpty extends Mock implements PostServices {}

class MockUserServiceEmpty extends Mock implements UserServices {}

main() async {
  MockUserService userServices = MockUserService();
  MockPostService postServices = MockPostService();
  MockUserServiceEmpty userServicesEmpty = MockUserServiceEmpty();
  MockPostServiceEmpty postServicesEmpty = MockPostServiceEmpty();
  PostBloc? postBloc;
  final postGetdata = await postServices.getData();
  final usergetUserData = await userServices.getUserData('aaa@gmail.com');
  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
  });

  setUp(() async {
    postServices = MockPostService();
    userServices = MockUserService();
    postBloc = PostBloc(userServices: userServices, postServices: postServices);
  });

  tearDown(() {
    postBloc?.close();
  });

  blocTest('emits [] when no event is added',
      build: () {
        postServices = MockPostService();
        userServices = MockUserService();
        return PostBloc(userServices: userServices, postServices: postServices);
      },
      expect: () => []);
  blocTest(
      'emits [PostFailure] when [PostRequested] is called and service throws error',
      build: () {
        postServicesEmpty = MockPostServiceEmpty();
        userServicesEmpty = MockUserServiceEmpty();
        return PostBloc(
            userServices: userServicesEmpty, postServices: postServicesEmpty);
      },
      act: (PostBloc bloc) => bloc.add(PostRequested()),
      expect: () =>
          [PostLoadFailure(errorMessage: RecipeFeedText.loadingFail)]);

  blocTest(
      'emits [PostLoadSuccess] when [PostRequested] is called and service throws success',
      build: () {
        MockPostService postServices = MockPostService();
        MockUserService userServices = MockUserService();
        return PostBloc(userServices: userServices, postServices: postServices);
      },
      act: (PostBloc bloc) => bloc.add(PostRequested()),
      expect: () =>
          [PostLoadSuccess(posts: postGetdata, users: usergetUserData)]);
}
