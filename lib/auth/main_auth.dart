import 'package:firebase_auth/firebase_auth.dart';
import 'package:travial/auth/base_auth.dart';

class MainAuth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> signUp(String email, String password) async{
    try{
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return user;

    }
    catch(e){
      print('ERROR :: $e');
    }

    return null;
    //return user.uid;
  }

  @override
  Future<FirebaseUser> signIn(String email, String password) async{
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //return user.uid;
      return user;
    }
    catch(e){
      print('ERROR :: $e');
    }
    return null;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<FirebaseUser> getCurrentUser() async{
    return await _firebaseAuth.currentUser();
  }

  @override
  Future<bool> isEmailVerified() {
    // TODO: implement isEmailVerified
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  
}