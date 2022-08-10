import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authUserState();
  Future<User?> getCurrentUser();
  Future<User?> signInAnonymously();
  Future<void> signOut();
}

class Auth implements AuthBase {


  @override
  Stream<User?> authUserState() => _firebaseAuth.authStateChanges();
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User?> getCurrentUser() async => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;
}
