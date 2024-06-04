import 'package:flutter/material.dart';
import 'package:todo_list_v1/models/task.dart';
import 'package:todo_list_v1/screens/tasks_details.dart';

class TaskPreview extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onChanged;

  const TaskPreview({Key? key, required this.task, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: task.completed ? Colors.green : Colors.orange,
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.content),
        trailing: Checkbox(
          value: task.completed,
          onChanged: onChanged,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetails(task: task),
            ),
          );
        },
      ),
    );
  }
}