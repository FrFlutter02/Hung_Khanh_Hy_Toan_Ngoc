import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/constant_text.dart';
import '../models/post_model.dart';

class PostServices {
  final FirebaseFirestore _firebaseFirestore;

  PostServices({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<List<Post>> getData() async {
    return _firebaseFirestore
        .collection("post")
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) => Post.fromSnapshot(doc)).toList();
      } else {
        throw RecipeFeedText.loadingFail;
      }
    });
  }
}
