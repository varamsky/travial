import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travial/auth/auth_status_enum.dart';
import 'package:travial/auth/main_auth.dart';
import 'package:travial/screens/login_screen.dart';
import 'package:travial/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final MainAuth auth;
  final FirebaseUser user;
  final WhichSignIn whichSignIn;

  HomeScreen(
      {@required this.auth, @required this.user, @required this.whichSignIn});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 22.0,
                backgroundColor: Color(0xFFFF0057),
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: (widget.user.photoUrl == null)
                      ? AssetImage('lib/assets/default-user-icons8.png')
                      : NetworkImage(widget.user.photoUrl),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Hi, ${(widget.user.displayName == null)?'User':(widget.user.displayName.split(' ')[0])}',
                // to extract only the first name
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          elevation: 1.0,
          actions: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFFFE8EF)),
              child: IconButton(
                color: Colors.red,
                  icon: Icon(Icons.notifications_none,color: Color(0xFFFF0057),),
                  onPressed: (){},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFFFE8EF)),
                child: IconButton(
                  color: Colors.red,
                  icon: Icon(Icons.message,color: Color(0xFFFF0057),),
                  onPressed: (){},
                ),
              ),
            ),
            /*RaisedButton(
              color: Colors.red,
                elevation: 0.0,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFFFE8EF)),
                  child: Icon(Icons.notifications_none,color: Color(0xFFFF0057),),
                ),
                onPressed: () {}),
            RaisedButton(
              color: Colors.transparent,
                elevation: 0.0,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFFFE8EF)),
                  child: Icon(Icons.message,color: Color(0xFFFF0057),),
                ),
                onPressed: () {}),*/
          ]
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ProfileScreen(
                        auth: widget.auth,
                        user: widget.user,
                        whichSignIn: widget.whichSignIn))),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.teal,
                  child: CircleAvatar(
                    radius: 23.0,
                    backgroundImage: (widget.user.photoUrl == null)
                        ? AssetImage('lib/assets/default-user-icons8.png')
                        : NetworkImage(widget.user.photoUrl),
                  ),
                ),
              ),
              Text('Logged in user :: ${widget.user.email} ${widget.user.uid}'),
              RaisedButton(
                child: Text('Log Out'),
                onPressed: () async {
                  switch (widget.whichSignIn) {
                    case WhichSignIn.WITH_EMAIL:
                      await widget.auth.signOutWithEmail().whenComplete(() {
                        print('Signed Out with Email');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()),
                            (route) => false);
                      });
                      break;
                    case WhichSignIn.WITH_GOOGLE:
                      await widget.auth.signOutWithGoogle().whenComplete(() {
                        print('Signed Out with Google');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()),
                            (route) => false);
                      });
                      break;
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currIndex,
          onTap: (int index) {
            setState(() {
              currIndex = index;
            });
            if (index == 4) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfileScreen(
                      auth: widget.auth,
                      user: widget.user,
                      whichSignIn: widget.whichSignIn)));
              currIndex = 0;
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    color: Color(0xFFFF0057),
                  ),
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Color(0xFFFF0057),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                title: Text(
                  "Search",
                  style: TextStyle(
                    color: Color(0xFFFF0057),
                  ),
                ),
                activeIcon: Icon(
                  Icons.search,
                  color: Color(0xFFFF0057),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                title: Text(""),
                activeIcon: Icon(
                  Icons.add,
                  color: Color(0xFFFF0057),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.explore,
                  color: Colors.black,
                ),
                title: Text(
                  "Explore",
                  style: TextStyle(
                    color: Color(0xFFFF0057),
                  ),
                ),
                activeIcon: Icon(
                  Icons.explore,
                  color: Color(0xFFFF0057),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Color(0xFFFF0057),
                  ),
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: Color(0xFFFF0057),
                )),
          ],
        ),
      ),
    );
  }
}
