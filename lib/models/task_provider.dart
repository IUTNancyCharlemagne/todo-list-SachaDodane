import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'task.dart';

class TasksProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    print('Fetching tasks from Supabase...');
    final response = await _client.from('tasks').select().execute();
    if (response.error == null) {
      print('Fetched tasks successfully: ${response.data}');
      final List<dynamic> data = response.data;
      _tasks = data.map((json) => Task.fromJson(json)).toList();
      notifyListeners();
    } else {
      print('Failed to fetch tasks: ${response.error!.message}');
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<void> addTask(Task task) async {
    print('Adding task: ${task.toJson()}');
    final taskData = task.toJson();
    taskData.remove('id'); // Remove the id field before insertion
    final response = await _client.from('tasks').insert(taskData).execute();
    if (response.error == null) {
      print('Added task successfully: ${response.data}');
      task.id = response.data[0]['id'];
      _tasks.add(task);
      notifyListeners();
    } else {
      print('Failed to add task: ${response.error!.message}');
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(Task task) async {
    print('Updating task: ${task.toJson()}');
    if (task.id == null) {
      print('Task ID is null, skipping update');
      return;
    }
    final response = await _client
        .from('tasks')
        .update(task.toJson())
        .eq('id', task.id)
        .execute();
    if (response.error == null) {
      print('Updated task successfully: ${response.data}');
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        notifyListeners();
      }
    } else {
      print('Failed to update task: ${response.error!.message}');
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    print('Deleting task with id: $id');
    final response = await _client.from('tasks').delete().eq('id', id).execute();
    if (response.error == null) {
      print('Deleted task successfully: ${response.data}');
      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
    } else {
      print('Failed to delete task: ${response.error!.message}');
      throw Exception('Failed to delete task');
    }
  }
}
