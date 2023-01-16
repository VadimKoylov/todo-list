import 'package:todo/features/main_page/entities/task_model.dart';
import 'package:todo/features/main_page/widgets/main_page.dart';

class FormatTasks {
  static List<TaskModel> getTasks(List<TaskModel> tasks, Completed status) {
    switch (status) {
      case Completed.all:
        return tasks;
      case Completed.activity:
        return tasks
            .where((element) => element.isCompleted == 'false')
            .toList();
      case Completed.completed:
        return tasks.where((element) => element.isCompleted == 'true').toList();
    }
  }
}
