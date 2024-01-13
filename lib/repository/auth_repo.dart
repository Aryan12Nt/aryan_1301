import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class AuthRepo {
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final fb.UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseAuthUser(userCredential.user!);
  }

  Future<UserModel> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    final fb.UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebaseAuthUser(userCredential.user!);
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception("Sign-out failed: $e");
    }
  }
}
