import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/features/main_page/domain/entity/entities.dart';

abstract class IMainPageRepository {
  Box<TaskModel> readBox();

  Future<Box<TaskModel>> removeTasks({required final Box<TaskModel> tasksBox});

  Future<Box<TaskModel>> removeTask({
    required final Box<TaskModel> tasksBox,
    required final int taskIndex,
  });
}

class MainPageRepository implements IMainPageRepository {
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

  @override
  Future<Box<TaskModel>> removeTask({
    required Box<TaskModel> tasksBox,
    required int taskIndex,
  }) async {
    try {
      tasksBox.deleteAt(taskIndex);
      return tasksBox;
    } catch (e, trace) {
      log('ERROR: $e');
      log('ERROR: $trace');
      rethrow;
    }
  }
}
