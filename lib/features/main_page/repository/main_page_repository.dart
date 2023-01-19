import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/features/main_page/entities/task_model.dart';

abstract class IMainPageRepository {
  Box<TaskModel> readBox();

  Future<void> writeTask({required final TaskModel task});

  Future<Box<TaskModel>> removeTasks({required final Box<TaskModel> tasksBox});
}

class MainPageRepository implements IMainPageRepository {
  // late final AppDatabase _database;

  @override
  Box<TaskModel> readBox() {
    try {
      final tasksBox = Hive.box<TaskModel>("TODO");
      return tasksBox;
    } catch (e, trace) {
      log('ERROR: $e');
      log('ERROR: $trace');
      rethrow;
    }
  }

  @override
  Future<void> writeTask({required TaskModel task}) async {
    try {
      // await _database.writeTask(task);
    } catch (e, trace) {
      log('ERROR: $e');
      log('ERROR: $trace');
      rethrow;
    }
  }

  @override
  Future<Box<TaskModel>> removeTasks({required Box<TaskModel> tasksBox}) async {
    try {
      for (int i = 0; i < tasksBox.values.toList().length; i++) {
        if (tasksBox.values.toList()[i].isCompleted == 'true') {
          tasksBox.deleteAt(i);
          i--;
        }
      }
      return tasksBox;
    } catch (e, trace) {
      log('ERROR: $e');
      log('ERROR: $trace');
      rethrow;
    }
  }
}
