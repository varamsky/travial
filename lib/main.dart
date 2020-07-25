import 'package:flutter/material.dart';
import 'package:travial/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travial App',
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.black,fontSize: 20.0),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

