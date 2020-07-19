import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travial/auth/auth_status_enum.dart';
import 'package:travial/auth/main_auth.dart';

class ProfileScreen extends StatelessWidget {
  final MainAuth auth;
  final FirebaseUser user;
  final WhichSignIn whichSignIn;

  ProfileScreen(
      {@required this.auth, @required this.user, @required this.whichSignIn});

  final double avatarRadius = 50.0;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.green,
                    width: deviceWidth,
                    height: deviceHeight / 3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: avatarRadius + 10.0),
                    child: Text(
                      user.displayName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'New Delhi, India',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ProfileButtons(
                        text: 'Follow',
                      ),
                      ProfileButtons(
                        text: 'Message',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FollowWidgets(
                        number: '6',
                        achievement: 'Places',
                      ),
                      MyVerticalDivider(),
                      FollowWidgets(
                        number: '32',
                        achievement: 'Followers',
                      ),
                      MyVerticalDivider(),
                      FollowWidgets(
                        number: '50',
                        achievement: 'Following',
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          icon: SvgPicture.asset('lib/assets/instagram.svg'),
                          onPressed: () {}),
                      IconButton(
                          icon: SvgPicture.asset('lib/assets/facebook.svg'),
                          onPressed: () {}),
                      IconButton(
                          icon: SvgPicture.asset('lib/assets/twitter.svg'),
                          onPressed: () {}),
                    ],
                  ),
                  Divider(),
                  PostsGrid(),
                ],
              ),
              Positioned(
                top: deviceHeight / 3,
                left: deviceWidth / 2,
                child: FractionalTranslation(
                  translation: Offset(-0.5, -0.5),
                  child: CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: Colors.teal,
                    child: CircleAvatar(
                      radius: avatarRadius - 2,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: avatarRadius - 4,
                        backgroundImage: (user.photoUrl == null)
                            ? AssetImage('lib/assets/default-user-icons8.png')
                            : NetworkImage(user.photoUrl),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostsGrid extends StatelessWidget {
  const PostsGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: ScrollPhysics(),
      itemCount: 10,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.yellow,
          child: Text('index $index'),
        );
      },
    );
  }
}

class MyVerticalDivider extends StatelessWidget {
  const MyVerticalDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5,
      height: 40.0,
      color: Colors.grey,
    );
  }
}

class FollowWidgets extends StatelessWidget {
  final String number, achievement;

  const FollowWidgets({
    Key key,
    @required this.number,
    @required this.achievement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          Text(
            number,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            achievement,
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class ProfileButtons extends StatelessWidget {
  final String text;

  const ProfileButtons({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0.0,
      color: Color(0xffFFE8EF),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.pink,
        ),
      ),
      onPressed: () {},
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );
  }
}
