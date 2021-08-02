import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class UserServices {
  late FirebaseAuth firebaseAuth;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  UserServices() : firebaseAuth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Future<bool> isLoggedIn() async {
    var currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> logIn(String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> logOut() async {
    firebaseAuth.signOut();
  }

  Future<UserModel?> signUp(
      String fullName, String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel =
          UserModel(fullName: fullName, email: email, password: password);
      await userCollection
          .doc(email)
          .set({'email': email, 'password': password});
      return userModel;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> existsInDatabase(String fieldName, String fieldValue) async {
    try {
      return await userCollection
          .where(fieldName, isEqualTo: fieldValue.isEmpty ? '' : fieldValue)
          .get()
          .then((value) {
        return value.docs.length > 0;
      });
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}
