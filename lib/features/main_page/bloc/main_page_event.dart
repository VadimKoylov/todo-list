part of 'main_page_bloc.dart';

abstract class MainPageEvent {
  const MainPageEvent();
}

class MainPageEventReadTasks extends MainPageEvent {}

class MainPageEventWriteTasks extends MainPageEvent {
  const MainPageEventWriteTasks({
    required this.task,
    required this.tasksBox,
  });

  final TaskModel task;
  final Box<TaskModel> tasksBox;
}

class MainPageEventRemoveTasks extends MainPageEvent {
  const MainPageEventRemoveTasks({
    required this.tasksBox,
  });

  final Box<TaskModel> tasksBox;
}

class MainPageEventRemoveTask extends MainPageEvent {
  const MainPageEventRemoveTask({
    required this.taskIndex,
    required this.tasksBox,
  });

  final int taskIndex;
  final Box<TaskModel> tasksBox;
}

class MainPageEventChangeCompletedType extends MainPageEvent {
  const MainPageEventChangeCompletedType({
    required this.completedStatus,
    required this.tasksBox,
  });

  final Completed completedStatus;
  final Box<TaskModel> tasksBox;
}

class MainPageEventMarkAllCompleted extends MainPageEvent {
  const MainPageEventMarkAllCompleted({
    required this.tasksBox,
  });

  final Box<TaskModel> tasksBox;
}

class MainPageEventMarkTaskCompleted extends MainPageEvent {
  const MainPageEventMarkTaskCompleted({
    required this.tasksBox,
    required this.index,
    required this.value,
  });

  final Box<TaskModel> tasksBox;
  final int index;
  final bool value;
}
