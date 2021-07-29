import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  FirebaseAuth? firebaseAuth;

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
      await firebaseAuth?.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }
}
