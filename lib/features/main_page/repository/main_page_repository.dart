import 'package:todo/core/database/app_database.dart';
import 'package:todo/features/main_page/entities/task.dart';

abstract class IMainPageRepository {
  Future<List<Task>> readTasks();

  Future<void> writeTask({required final Task task});

  Future<void> removeTasks({required final List<Task> tasks});
}

class MainPageRepository implements IMainPageRepository {
  late final AppDatabase _database;

  MainPageRepository({required AppDatabase database}) : _database = database;

  @override
  Future<List<Task>> readTasks() async {
    final tasks = await _database.readDatabase();
    return List<Task>.from((tasks).map((x) => Task.fromJson(x)));
  }

  @override
  Future<void> removeTasks({required List<Task> tasks}) async {
    for (var element in tasks) {
      if (element.isCompleted == 'true') {
        await _database.deleteTask(element);
      }
    }
  }

  @override
  Future<void> writeTask({required Task task}) async {
    await _database.writeTask(task);
  }
}
