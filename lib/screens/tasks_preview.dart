import 'package:flutter/material.dart';
import 'package:todo_list_v1/models/task.dart'; // Assurez-vous d'importer correctement votre classe Task

class TaskPreview extends StatelessWidget {
  final Task task;

  const TaskPreview({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.content),
      trailing: task.completed
          ? Icon(Icons.check_circle, color: Colors.green)
          : Icon(Icons.radio_button_unchecked, color: Colors.red),
    );
  }
}
