import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User?> currentUser();
  Future<User?> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {
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
