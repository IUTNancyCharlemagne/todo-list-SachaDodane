import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'tasks_preview.dart';
import '../models/task.dart';
class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks().then((tasks) {
      setState(() {
        _tasks = tasks;
      });
    });
  }

  Future<List<Task>> _fetchTasks() async {
    List<Task> tasks = [];
    for (int i = 0; i < 100; i++) {
      tasks.add(Task(
        id: i,
        content: faker.lorem.sentence(),
        completed: faker.randomGenerator.boolean(),
        title: faker.lorem.word(),
      ));
    }
    return tasks;
  }

  void _toggleTaskCompletion(Task task, bool? completed) {
    setState(() {
      task.completed = completed!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        Task task = _tasks[index];
        return TaskPreview(
          task: task,
          onChanged: (completed) => _toggleTaskCompletion(task, completed),
        );
      },
    );
  }
}