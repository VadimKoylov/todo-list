import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/features/main_page/entities/task_model.dart';
import 'package:todo/todolist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  runApp(const Todolist());
}

Future<void> initDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('TODO');
}
