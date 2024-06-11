import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_v1/screens/tasks_master.dart';
import 'package:todo_list_v1/models/task_provider.dart';

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TasksProvider()),
      ],
      child: MaterialApp(
        title: 'ToDo List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TasksMaster(),
      ),
    );
  }
}
