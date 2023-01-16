part of 'main_page_bloc.dart';

abstract class MainPageEvent {
  const MainPageEvent();
}

class MainPageEventReadTasks extends MainPageEvent {}

class MainPageEventWriteTasks extends MainPageEvent {
  const MainPageEventWriteTasks({
    required this.task,
    required this.tasks,
  });

  final TaskModel task;
  final List<TaskModel> tasks;
}

class MainPageEventRemoveTasks extends MainPageEvent {
  const MainPageEventRemoveTasks({
    required this.tasks,
  });

  final List<TaskModel> tasks;
}

class MainPageEventChangeCompletedType extends MainPageEvent {
  const MainPageEventChangeCompletedType({
    required this.completedStatus,
    required this.tasks,
  });

  final Completed completedStatus;
  final List<TaskModel> tasks;
}

class MainPageEventMarkAllCompleted extends MainPageEvent {
  const MainPageEventMarkAllCompleted({
    required this.tasks,
  });

  final List<TaskModel> tasks;
}

class MainPageEventMarkTaskCompleted extends MainPageEvent {
  const MainPageEventMarkTaskCompleted({
    required this.tasks,
    required this.index,
    required this.value,
  });

  final List<TaskModel> tasks;
  final int index;
  final bool value;
}
