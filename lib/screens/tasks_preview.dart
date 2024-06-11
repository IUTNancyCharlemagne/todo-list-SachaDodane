import 'package:flutter/material.dart';
import 'package:todo_list_v1/models/task.dart';
import 'package:intl/intl.dart';

class TaskPreview extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTap;

  const TaskPreview({
    Key? key,
    required this.task,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(task.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.content),
          if (task.dueDate != null)
            Text('Due: ${DateFormat('yyyy-MM-dd').format(task.dueDate!)}'),
        ],
      ),
      trailing: Checkbox(
        value: task.completed,
        onChanged: onChanged,
      ),
    );
  }
}
