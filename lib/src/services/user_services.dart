import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  final FirebaseAuth? firebaseAuth;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  UserServices() : firebaseAuth = FirebaseAuth.instance;

  Future<User?> logIn(String email, String password) async {
    try {
      var auth = await firebaseAuth?.signInWithEmailAndPassword(
          email: email, password: password);
      return auth?.user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> isLoggedIn() async {
    var currentUser = firebaseAuth?.currentUser;
    return currentUser != null;
  }

  Future<void> logOut() async {
    firebaseAuth?.signOut();
  }

  Future<User?> getCurrentUser() async {
    return firebaseAuth?.currentUser;
  }

  Future<void> signUp(String fullName, String email, String password) async {
    try {
      bool userDidNotExist = await userCollection
          .where('email', isEqualTo: email)
          .get()
          .then((value) {
        return value.docs.length == 0;
      });
      if (userDidNotExist) {
        await firebaseAuth?.createUserWithEmailAndPassword(
            email: email, password: password);
      } else {
        print('already exist!');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
