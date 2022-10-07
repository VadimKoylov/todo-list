import 'dart:async';
import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:todo/features/main_page/entities/task.dart';

class AppDatabase {
  late final Database _database;

  AppDatabase({required Database database}) : _database = database;

  Future<List<Map<String, Object?>>> readDatabase() async {
    try {
      return await _database.query('tasks');
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<void> writeTask(Task task) async {
    try {
      _database.insert('tasks', task.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteTask(Task task) async {
    _database.rawDelete('DELETE FROM tasks WHERE id = "${task.id}"');
  }
}
