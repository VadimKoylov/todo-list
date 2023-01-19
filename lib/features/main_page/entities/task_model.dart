import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String body;
  @HiveField(3)
  String isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isCompleted,
  });
}
