import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User?> currentUser();
  Future<User?> signInAnonymously();
  Future<void> signOut();
  test();
}

class Auth implements AuthBase {
  @override
  test(){print('Auth');}
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User?> currentUser() async => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
