import 'package:flutter/material.dart';
import 'package:todo_list_v1/models/task.dart';

class TaskDetails extends StatefulWidget {
  final Task task;
  final Function(Task) onSave;

  const TaskDetails({super.key, required this.task, required this.onSave});

  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _contentController = TextEditingController(text: widget.task.content);
    _completed = widget.task.completed;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveTask() {
    widget.task.title = _titleController.text;
    widget.task.content = _contentController.text;
    widget.task.completed = _completed;
    widget.onSave(widget.task);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task updated successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  setState(() {
                    widget.task.title = value;
                  });
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                onChanged: (value) {
                  setState(() {
                    widget.task.content = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Completed'),
                value: _completed,
                onChanged: (value) {
                  setState(() {
                    _completed = value!;
                    widget.task.completed = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveTask,
        child: Icon(Icons.save),
      ),
    );
  }
}
