import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'tasks_preview.dart';
import '../models/task.dart';

class TasksMaster extends StatefulWidget {
  @override
  _TasksMaster createState() => _TasksMaster();
}

class _TasksMaster extends State<TasksMaster> {
  Future<List<Task>> _fetchTasks() {
    List<Task> tasks = [];
    for (var i = 0; i < 100; i++) {
      tasks.add(Task(
        id: i,
        content: faker.lorem.sentence(),
        completed: faker.randomGenerator.boolean(),
        title: faker.lorem.word(),
      ));
    }
    return Future<List<Task>>.value(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks Master'),
      ),
      body: FutureBuilder<List<Task>>(
        future: _fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else {
            List<Task> tasks = snapshot.data!;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                return TaskPreview(task: task);
              },
            );
          }
        },
      ),
    );
  }
}