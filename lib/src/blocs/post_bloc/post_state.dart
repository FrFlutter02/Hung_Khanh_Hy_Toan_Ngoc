import 'package:equatable/equatable.dart';

import '../../models/user_model.dart';
import '../../models/post_model.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {}

class PostLoadSuccess extends PostState {
  final List<Post> posts;
  final List<UserModel> users;
  PostLoadSuccess(
      {this.posts = const <Post>[], this.users = const <UserModel>[]});

  @override
  List<Object> get props => [posts, users];
}

class PostLoadFailure extends PostState {
  final String errorMessage;

  PostLoadFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
