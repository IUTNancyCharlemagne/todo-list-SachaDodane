import 'package:flutter/material.dart';
import 'screens/tasks_master.dart'; // Assurez-vous d'importer correctement TasksMaster

class ToDoListApp extends StatefulWidget {
  const ToDoListApp({Key? key}) : super(key: key);

  @override
  _ToDoListAppState createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ToDo List'),
        ),
        body: TasksMaster(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
