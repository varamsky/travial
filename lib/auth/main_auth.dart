import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travial/auth/base_auth.dart';

class MainAuth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<FirebaseUser> signUpWithEmail(String email, String password) async{
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
  Future<FirebaseUser> signInWithEmail(String email, String password) async{
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //return user.uid;
      return user;
    }
    catch(e){
      print('ERROR EMAIL_SIGN_IN :: $e');
    }
    return null;
  }

  @override
  Future<void> signOutWithEmail() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<FirebaseUser> signInWithGoogle() async{
    try{
      final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

      final AuthResult result = await _firebaseAuth.signInWithCredential(credential);
      final FirebaseUser user = result.user;

      return user;
    }
    catch(e){
      print('ERROR GOOGLE_SIGN_IN :: $e');
    }

    return null;
  }

  @override
  Future<void> signOutWithGoogle() {
    return _googleSignIn.signOut();
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