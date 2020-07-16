import 'package:flutter/material.dart';
import 'package:travial/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travial App',
      home: LoginScreen(),
    );
  }
}

