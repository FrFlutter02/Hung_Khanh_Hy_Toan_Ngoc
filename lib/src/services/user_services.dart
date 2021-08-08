import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserServices {
  late FirebaseAuth firebaseAuth;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  UserServices() : firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(UserModel userModel) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
            email: userModel.email, password: userModel.password);
    await userCollection.doc(userModel.email).set(userModel.toMap());
    return userCredential;
  }

  Future<bool> existsInDatabase(String fieldName, String fieldValue) async {
    return await userCollection
        .where(fieldName, isEqualTo: fieldValue.isEmpty ? '' : fieldValue)
        .get()
        .then((value) {
      return value.docs.length > 0;
    });
  }
}
