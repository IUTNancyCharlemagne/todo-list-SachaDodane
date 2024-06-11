import 'package:flutter/material.dart';
import 'package:todo_list_v1/models/task.dart';
import 'package:intl/intl.dart';

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
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _contentController = TextEditingController(text: widget.task.content);
    _completed = widget.task.completed;
    _dueDate = widget.task.dueDate;
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
      initialDate: _dueDate ?? DateTime.now(),
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
    widget.task.title = _titleController.text;
    widget.task.content = _contentController.text;
    widget.task.completed = _completed;
    widget.task.dueDate = _dueDate;
    print('Saving updated task: ${widget.task.toJson()}');
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
      body: Container(
        color: Colors.blue[50],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.task.title = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.task.content = value;
                    });
                  },
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('Completed'),
                  value: _completed,
                  onChanged: (value) {
                    setState(() {
                      _completed = value!;
                      widget.task.completed = value;
                    });
                  },
                  activeColor: Colors.orange,
                  checkColor: Colors.white,
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      _dueDate == null
                          ? 'No date chosen'
                          : 'Date: ${DateFormat('yyyy-MM-dd').format(_dueDate!)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () => _selectDueDate(context),
                      child: Text('Choose Date'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _saveTask,
                    icon: Icon(Icons.save),
                    label: Text('Save Task'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                      backgroundColor: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
