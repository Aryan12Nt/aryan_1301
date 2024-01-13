import 'package:firebase_auth/firebase_auth.dart' as fa;
class UserModel {
  final String? uid;
  final String? email;
  final String? userName;

  const UserModel({
    this.uid,
    this.email,
    this.userName,
  });

  factory UserModel.fromFirebaseAuthUser(fa.User firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      userName: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "email":email,
      'uid': uid,
      'userName': userName,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      userName: json['userName'],
    );
  }

  static const UserModel emptyUserData = UserModel();
}