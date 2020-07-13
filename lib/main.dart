import 'package:flutter/material.dart';
import 'package:travial/screens/home_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: HomeScreen(),
    );
  }
}

