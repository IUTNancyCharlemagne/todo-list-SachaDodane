import 'package:flutter/material.dart';
import 'package:todo_list_v1/models/task.dart';
import 'package:intl/intl.dart';

class TaskForm extends StatefulWidget {
  final Function(Task) onSave;

  const TaskForm({super.key, required this.onSave});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _completed = false;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        id: null,
        title: _titleController.text,
        content: _contentController.text,
        completed: _completed,
        dueDate: _dueDate,
      );
      print('Saving task: ${newTask.toJson()}');
      widget.onSave(newTask);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task created successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Completed'),
                value: _completed,
                onChanged: (value) {
                  setState(() {
                    _completed = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    _dueDate == null
                        ? 'No due date chosen'
                        : 'Due Date: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}',
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => _selectDueDate(context),
                    child: Text('Choose Due Date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
