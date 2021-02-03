import 'package:flutter/material.dart';
import 'package:todo_app_sqflite/Screens/homeScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      title: 'To Do App',
    );
  }
}
