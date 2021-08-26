import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mobile_app/src/constants/constant_text.dart';

import '../../services/post_service.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostServices _postService;
  PostBloc({
    required PostServices postServices,
  })  : _postService = postServices,
        super(PostLoading());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostLoaded) {
      try {
        final posts = await _postService.getData();
        yield PostLoadSuccess(posts: posts);
      } catch (e) {
        yield PostLoadFailure(errorMessage: RecipeFeedText.loadingFail);
      }
    }
  }
}
