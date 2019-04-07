import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/ui/newscreen.dart';
import 'package:flutter_assignment_02/ui/todoscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Assignment 02',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => TodoScreen(),
        "/newScreen": (context) => NewScreen(),
      },
    );
  }
}
