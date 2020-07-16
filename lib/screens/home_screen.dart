import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser user;

  HomeScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Home Screen'),),
        body: Center(
          child: Text('Logged in user :: ${user.email} ${user.uid}'),
        ),
      ),
    );
  }
}
