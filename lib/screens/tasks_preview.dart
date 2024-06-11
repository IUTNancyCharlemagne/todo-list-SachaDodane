import 'package:flutter/material.dart';
import 'package:todo_list_v1/models/task.dart';

class TaskPreview extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTap;

  const TaskPreview({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onTap,
  });

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
        onTap: onTap,
      ),
    );
  }
}
