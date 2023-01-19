import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/features/main_page/entities/task_model.dart';
import 'package:todo/features/main_page/widgets/main_page.dart';

class FormatTasks {
  static List<TaskModel> getTasks(Box<TaskModel> tasksBox, Completed status) {
    switch (status) {
      case Completed.all:
        return tasksBox.values.toList();
      case Completed.activity:
        return tasksBox.values
            .toList()
            .where((element) => element.isCompleted == 'false')
            .toList();
      case Completed.completed:
        return tasksBox.values
            .toList()
            .where((element) => element.isCompleted == 'true')
            .toList();
    }
  }
}
