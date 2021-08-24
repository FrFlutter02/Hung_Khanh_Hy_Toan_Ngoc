import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String recipeId;
  final String userId;
  final String description;
  final int likes;
  final int comments;
  final String name;
  final String backgroundImage;

  const Post({
    required this.recipeId,
    required this.userId,
    required this.description,
    required this.likes,
    required this.comments,
    required this.name,
    required this.backgroundImage,
  });

  @override
  List<Object?> get props => [
        recipeId,
        userId,
        description,
        likes,
        comments,
        name,
        backgroundImage,
      ];

  static Post fromSnapshot(DocumentSnapshot snapshot) {
    Post post = Post(
      recipeId: snapshot['recipeId'],
      userId: snapshot['userId'],
      description: snapshot['description'],
      likes: snapshot['likes'],
      comments: snapshot['comments'],
      name: snapshot['name'],
      backgroundImage: snapshot['backgroundImage'],
    );
    return post;
  }
}
