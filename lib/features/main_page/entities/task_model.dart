import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String body;
  @HiveField(2)
  String isCompleted;

  TaskModel({
    required this.title,
    required this.body,
    required this.isCompleted,
  });
}
