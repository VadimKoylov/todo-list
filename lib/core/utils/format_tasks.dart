import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/enums/completed_status.dart';
import 'package:todo/features/main_page/domain/entity/entities.dart';

class FormatTasks {
  static List<TaskModel> getTasks(
    Box<TaskModel> tasksBox,
    CompletedStatus status,
  ) {
    switch (status) {
      case CompletedStatus.all:
        return tasksBox.values.toList();
      case CompletedStatus.activity:
        return tasksBox.values
            .toList()
            .where((element) => element.isCompleted == 'false')
            .toList();
      case CompletedStatus.completed:
        return tasksBox.values
            .toList()
            .where((element) => element.isCompleted == 'true')
            .toList();
    }
  }
}
