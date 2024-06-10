import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_v1/models/task.dart';
import 'package:todo_list_v1/models/task_provider.dart';
import 'package:todo_list_v1/screens/tasks_details.dart';
import 'package:todo_list_v1/screens/task_form.dart';
import 'package:todo_list_v1/screens/tasks_preview.dart';

class TasksMaster extends StatefulWidget {
  const TasksMaster({super.key});

  @override
  State<TasksMaster> createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  @override
  void initState() {
    super.initState();
    Provider.of<TasksProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks Master'),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, child) {
          final tasks = tasksProvider.tasks;
          if (tasks.isEmpty) {
            return Center(child: Text('No tasks found'));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TaskPreview(
                task: task,
                onChanged: (value) {
                  setState(() {
                    task.completed = value!;
                    tasksProvider.updateTask(task);
                  });
                },
                onTap: () async {
                  final updatedTask = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetails(
                        task: task,
                        onSave: (updatedTask) {
                          tasksProvider.updateTask(updatedTask);
                        },
                      ),
                    ),
                  );
                  if (updatedTask != null) {
                    tasksProvider.updateTask(updatedTask);
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskForm(
                onSave: (newTask) {
                  Provider.of<TasksProvider>(context, listen: false).addTask(newTask);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
