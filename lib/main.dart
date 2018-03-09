import 'package:flutter/material.dart';
import 'package:todo_app/views/todos_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ToDo\'s',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: new ToDosPage(),
    );
  }
}
