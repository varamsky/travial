import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travial/auth/auth_status_enum.dart';
import 'package:travial/auth/main_auth.dart';
import 'package:travial/screens/login_screen.dart';
import 'package:travial/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final MainAuth auth;
  final FirebaseUser user;
  final WhichSignIn whichSignIn;

  HomeScreen({@required this.auth,@required this.user,@required this.whichSignIn});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Home Screen'),),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProfileScreen(auth: auth, user: user, whichSignIn: whichSignIn))),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.teal,
                  child: CircleAvatar(
                    radius: 23.0,
                    backgroundImage: (user.photoUrl == null)?AssetImage('lib/assets/default-user-icons8.png'):NetworkImage(user.photoUrl),
                  ),
                ),
              ),
              Text('Logged in user :: ${user.email} ${user.uid}'),
              RaisedButton(
                child: Text('Log Out'),
                onPressed: () async{
                  switch(whichSignIn){
                    case WhichSignIn.WITH_EMAIL:
                      await auth.signOutWithEmail().whenComplete((){
                        print('Signed Out with Email');
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()), (route) => false);
                      });
                      break;
                    case WhichSignIn.WITH_GOOGLE:
                      await auth.signOutWithGoogle().whenComplete((){
                        print('Signed Out with Google');
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()), (route) => false);
                      });
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
