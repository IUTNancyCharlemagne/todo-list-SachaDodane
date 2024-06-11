import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_v1/models/task.dart';
import 'package:todo_list_v1/models/task_provider.dart';
import 'package:todo_list_v1/screens/task_form.dart';
import 'package:todo_list_v1/screens/tasks_details.dart';
import 'package:todo_list_v1/screens/tasks_preview.dart';

enum TaskFilter { all, completed, incomplete }

class TasksMaster extends StatefulWidget {
  @override
  _TasksMasterState createState() => _TasksMasterState();
}

class _TasksMasterState extends State<TasksMaster> {
  TaskFilter _filter = TaskFilter.all;
  late Future<void> _fetchTasksFuture;

  @override
  void initState() {
    super.initState();
    _fetchTasksFuture = Provider.of<TasksProvider>(context, listen: false).fetchTasks();
  }

  void _addTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskForm(
          onSave: (newTask) {
            Provider.of<TasksProvider>(context, listen: false).addTask(newTask);
          },
        ),
      ),
    );
  }

  void _editTask(BuildContext context, Task task) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskDetails(
          task: task,
          onSave: (updatedTask) {
            Provider.of<TasksProvider>(context, listen: false).updateTask(updatedTask);
          },
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog<TaskFilter>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Tasks'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RadioListTile<TaskFilter>(
                  title: const Text('All Tasks'),
                  value: TaskFilter.all,
                  groupValue: _filter,
                  onChanged: (TaskFilter? value) {
                    setState(() {
                      _filter = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<TaskFilter>(
                  title: const Text('Completed Tasks'),
                  value: TaskFilter.completed,
                  groupValue: _filter,
                  onChanged: (TaskFilter? value) {
                    setState(() {
                      _filter = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile<TaskFilter>(
                  title: const Text('Incomplete Tasks'),
                  value: TaskFilter.incomplete,
                  groupValue: _filter,
                  onChanged: (TaskFilter? value) {
                    setState(() {
                      _filter = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final tasks = tasksProvider.tasks.where((task) {
      switch (_filter) {
        case TaskFilter.completed:
          return task.completed;
        case TaskFilter.incomplete:
          return !task.completed;
        case TaskFilter.all:
        default:
          return true;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchTasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching tasks'));
          } else {
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: TaskPreview(
                    task: task,
                    onChanged: (bool? value) {
                      setState(() {
                        task.completed = value ?? false;
                        tasksProvider.updateTask(task);
                      });
                    },
                    onTap: () => _editTask(context, task),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () => _addTask(context),
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () => _showFilterDialog(context),
            child: Icon(Icons.filter_list),
            backgroundColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
