import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signInWithEmail(String email, String password);

  Future<FirebaseUser> signUpWithEmail(String email, String password);

  Future<void> signOutWithEmail();

  Future<FirebaseUser> signInWithGoogle();

  Future<void> signOutWithGoogle();

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();


  Future<bool> isEmailVerified();
}
