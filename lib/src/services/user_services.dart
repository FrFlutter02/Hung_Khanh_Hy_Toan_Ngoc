import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../src/models/user_model.dart';

class UserServices {
  late FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  UserServices() : firebaseAuth = FirebaseAuth.instance;

  Future<bool> existsInDatabase(String fieldName, String fieldValue) async {
    try {
      return await userCollection
          .where(fieldName, isEqualTo: fieldValue == '' ? '' : fieldValue)
          .get()
          .then((value) {
        return value.docs.length > 0;
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> logIn(UserModel userModel) async {
    var auth = await firebaseAuth.signInWithEmailAndPassword(
        email: userModel.email, password: userModel.password);
    return auth.user;
  }

  Future<void> logOut() async {
    firebaseAuth.signOut();
  }

  Future<void>? resetPassword(String email) {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential?> signUp(UserModel userModel) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
            email: userModel.email, password: userModel.password);
    await userCollection.doc(userModel.email).set(userModel.toMap());
    return userCredential;
  }

  Future<User?> getUser() async {
    return firebaseAuth.currentUser!;
  }

  Future<void> signOut() {
    return Future.wait([firebaseAuth.signOut()]);
  }

  Future<bool> isSignedIn() async {
    return firebaseAuth.currentUser != null;
  }
}
