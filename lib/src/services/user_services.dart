import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<bool> existsInDatabase(String fieldName, String fieldValue) async {
    try {
      return await userCollection
          .where(fieldName, isEqualTo: fieldValue == '' ? '' : fieldValue)
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
