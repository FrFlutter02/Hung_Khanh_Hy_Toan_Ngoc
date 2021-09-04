import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_bloc.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_event.dart';
import 'package:mobile_app/src/blocs/post_bloc/post_state.dart';
import 'package:mobile_app/src/services/post_service.dart';
import 'package:mobile_app/src/services/user_services.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../cloud_firestore_mock.dart';
import '../../mock/mock_post_service.dart';
import '../../mock/mock_user_service.dart';

class MockPostServiceEmpty extends Mock implements PostServices {}

class MockUserServiceEmpty extends Mock implements UserServices {}

main() async {
  PostBloc? postBloc;
  MockUserServiceEmpty userServicesEmpty = MockUserServiceEmpty();
  MockPostServiceEmpty postServicesEmpty = MockPostServiceEmpty();
  var postServices = MockPostServices();
  var userServices = MockUserServices();
  final postGetdata = await postServices.getData();
  final userGetData = await userServices.getUserData('aaa@gmail.com');

  setUpAll(() async {
    setupCloudFirestoreMocks();
    Firebase.initializeApp();
  });

  setUp(() async {
    postServices = MockPostServices();
    userServices = MockUserServices();
    postBloc = PostBloc(userServices: userServices, postServices: postServices);
  });

  tearDown(() {
    postBloc?.close();
  });

  blocTest('emits [] when no event is added',
      build: () {
        postServices = MockPostServices();
        userServices = MockUserServices();
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
      expect: () => [PostLoadFailure(errorMessage: 'Loading Failed')]);

  blocTest(
      'emits [PostLoadSuccess] when [PostRequested] is called and service throws success',
      build: () {
        postServices = MockPostServices();
        userServices = MockUserServices();
        return PostBloc(userServices: userServices, postServices: postServices);
      },
      act: (PostBloc bloc) => bloc.add(PostRequested()),
      expect: () => [PostLoadSuccess(posts: postGetdata, users: userGetData)]);
}
