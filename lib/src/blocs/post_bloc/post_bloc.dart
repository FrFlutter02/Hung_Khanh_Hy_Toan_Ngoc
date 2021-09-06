import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../constants/constant_text.dart';
import '../../services/user_services.dart';
import '../../services/post_service.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostServices _postService;
  final UserServices _userServices;
  PostBloc({
    required PostServices postServices,
    required UserServices userServices,
  })  : _postService = postServices,
        _userServices = userServices,
        super(PostLoading());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostRequested) {
      try {
        final posts = await _postService.getData();
        final users = await _userServices.getUserData('nntanhung@gmail.com');
        yield PostLoadSuccess(posts: posts, users: users);
      } catch (e) {
        yield PostLoadFailure(errorMessage: RecipeFeedText.loadingFailed);
      }
    }
  }
}
