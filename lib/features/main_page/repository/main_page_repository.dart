import 'dart:developer';

import 'package:todo/core/database/app_database.dart';
import 'package:todo/features/main_page/entities/task_model.dart';

abstract class IMainPageRepository {
  Future<List<TaskModel>> readTasks();

  Future<void> writeTask({required final TaskModel task});

  Future<void> removeTasks({required final List<TaskModel> tasks});
}

class MainPageRepository implements IMainPageRepository {
  late final AppDatabase _database;

  @override
  Future<List<TaskModel>> readTasks() async {
    try {
      final tasks = await _database.readDatabase();
      return List<TaskModel>.from((tasks).map((x) => TaskModel.fromJson(x)));
    } catch (e, trace) {
      log('ERROR: $e');
      log('ERROR: $trace');
      rethrow;
    }
  }

  @override
  Future<void> writeTask({required TaskModel task}) async {
    try {
      await _database.writeTask(task);
    } catch (e, trace) {
      log('ERROR: $e');
      log('ERROR: $trace');
      rethrow;
    }
  }

  @override
  Future<void> removeTasks({required List<TaskModel> tasks}) async {
    try {
      for (var element in tasks) {
        await _database.deleteTask(element);
      }
    } catch (e, trace) {
      log('ERROR: $e');
      log('ERROR: $trace');
      rethrow;
    }
  }
}
