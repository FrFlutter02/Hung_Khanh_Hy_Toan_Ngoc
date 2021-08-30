import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/src/blocs/login_bloc/login_bloc.dart';
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

class MockPostService extends Mock implements PostServices {}

class MockUserService extends Mock implements UserServices {
  // @override
  // Future<List<UserModel>> getUserData(UserModel userModel) async {
  //   return [];
  // }
}

main() {
  MockUserService userServices;
  MockPostService postServices;
  PostBloc? postBloc;

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
        postServices = MockPostService();
        userServices = MockUserService();
        return PostBloc(userServices: userServices, postServices: postServices);
      },
      act: (PostBloc bloc) => bloc.add(PostRequested()),
      expect: () =>
          [PostLoadFailure(errorMessage: RecipeFeedText.loadingFail)]);
  // blocTest(
  //     'emits [PostSuccess] when [PostRequested] is called and service throws success',
  //     build: () {
  //       postServices = MockPostService();
  //       userServices = MockUserService();
  //       return PostBloc(userServices: userServices, postServices: postServices);
  //     },
  //     act: (PostBloc bloc) => bloc.add(PostRequested()),
  //     expect: () => [PostLoadSuccess()]);
}
