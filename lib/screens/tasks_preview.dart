import 'package:flutter/material.dart';
import 'package:todo_list_v1/models/task.dart';
import 'package:intl/intl.dart';

class TaskPreview extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TaskPreview({
    Key? key,
    required this.task,
    required this.onChanged,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: task.completed ? Colors.green.shade100 : Colors.orange.shade100,
      child: ListTile(
        onTap: onTap,
        title: Text(
          task.title,
          style: TextStyle(decoration: task.completed ? TextDecoration.lineThrough : null),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.content),
            if (task.dueDate != null)
              Text('Date: ${DateFormat('yyyy-MM-dd').format(task.dueDate!)}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.completed,
              onChanged: onChanged,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
