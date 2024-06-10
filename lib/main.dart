import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_v1/todo_list_app.dart';
import 'package:todo_list_v1/models/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://cskyvytztbvghpiloibi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNza3l2eXR6dGJ2Z2hwaWxvaWJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc0OTE4ODgsImV4cCI6MjAzMzA2Nzg4OH0.LiI3cyhLzwdVaVJPx__v6kWaaITSFdqZSk8hAMUcBGE',
  );
  runApp(const ToDoListApp());
}
