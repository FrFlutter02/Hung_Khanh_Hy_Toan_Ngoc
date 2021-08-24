import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostLoaded extends PostEvent {}

class PostPageChanged extends PostEvent {
  final int postNumber;
  PostPageChanged(this.postNumber);

  @override
  List<Object> get props => [postNumber];
}
