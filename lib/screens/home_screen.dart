import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:travial/auth/auth_status_enum.dart';
import 'package:travial/auth/main_auth.dart';
import 'package:travial/screens/login_screen.dart';
import 'package:travial/screens/postCardWidget.dart';
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
  List<PostCardWidget> postList = List<PostCardWidget>();

  getImage(var imageReference) async {
    print('FirebaseStorage = $imageReference ${imageReference.toString()}');
    var url = await imageReference.getDownloadURL();
    print('download url => $url');
    print('image ${await imageReference.getName()}');

  }

  @override
  Widget build(BuildContext context) {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    //final imageReference = firebaseStorage.ref().child('https://console.firebase.google.com/project/travial/storage/travial.appspot.com/files');
    final imageReference =
        firebaseStorage.ref().child('shubhamkumar5772@gmail.com/738897.jpg');
    //getImage(imageReference);
    //print('image ${imageReference.getName()}');

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
                  'Hi, ${(widget.user.displayName == null) ? 'User' : (widget.user.displayName.split(' ')[0])}',
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
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFFFE8EF)),
                child: IconButton(
                  color: Colors.red,
                  icon: Icon(
                    Icons.notifications_none,
                    color: Color(0xFFFF0057),
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFFFE8EF)),
                  child: IconButton(
                    color: Colors.red,
                    icon: Icon(
                      Icons.message,
                      color: Color(0xFFFF0057),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ]),
        body: FutureBuilder(
          future: imageReference.getDownloadURL(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            return (snap.connectionState == ConnectionState.done)
                ? ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context,int index){
                buildCardList(snap.data);
                //buildCardList('https://images.pexels.com/photos/2007401/pexels-photo-2007401.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500');
                return postList[index];
              },
            )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        /*ListView.builder(
          itemCount: postList.length,
          itemBuilder: (BuildContext context,int index){
            return postList[index];
          },
        ),*/

        // TODO: Hiding the Bottom Navigation Bar on Scroll
        // url => https://medium.com/flutter/getting-to-the-bottom-of-navigation-in-flutter-b3e440b9386#:~:text=A%20typical%20bottom%20navigation%20bar,the%20button%20that%20was%20tapped.

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

  buildCardList(String imageUrl){
    for (int i = 0; i < 10; i++) {
      postList.add(PostCardWidget(
        user: widget.user,
        imageUrl: imageUrl,
      ));
    }
  }
}
