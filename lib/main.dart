import 'package:flutter/material.dart';
import 'todo_list_app.dart'; // Assurez-vous d'importer correctement votre classe ToDoListApp

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListApp(),
    );
  }
}
