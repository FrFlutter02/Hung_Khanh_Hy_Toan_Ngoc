import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app/src/models/user_model.dart';

class UserServices {
  late FirebaseAuth firebaseAuth;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  UserServices() : firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(
      String fullName, String email, String password) async {
    try {
      UserCredential? userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel =
          UserModel(fullName: fullName, email: email, password: password);
      await userCollection.doc(email).set(userModel.toMap());
      return userCredential;
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
