import 'package:firebase_auth/firebase_auth.dart';

class AppRepo {
  AppRepo._internal();
  static final AppRepo _appRepo =
  AppRepo._internal();
  factory AppRepo() {
    return _appRepo;
  }
  final uid = FirebaseAuth.instance.currentUser!.uid;
}
