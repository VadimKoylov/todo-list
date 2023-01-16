import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/main_page/entities/task_model.dart';
import 'package:todo/features/main_page/repository/main_page_repository.dart';
import 'package:todo/features/main_page/widgets/main_page.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(const MainPageState()) {
    on<MainPageEventReadTasks>(_onReadTasks);
    on<MainPageEventWriteTasks>(_onWriteTasks);
    on<MainPageEventRemoveTasks>(_onRemoveTasks);
    on<MainPageEventChangeCompletedType>(_onChangeCompletedType);
    on<MainPageEventMarkAllCompleted>(_onMarkAllCompleted);
    on<MainPageEventMarkTaskCompleted>(_onMarkTaskCompleted);
  }

  final IMainPageRepository _repository = MainPageRepository();

  Future<void> _onReadTasks(
    MainPageEventReadTasks event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final tasks = await _repository.readTasks();
    emit(
      state.copyWith(
        tasks: tasks,
        isLoading: false,
      ),
    );
  }

  Future<void> _onWriteTasks(
    MainPageEventWriteTasks event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    List<TaskModel> tasks = [];
    await _repository.writeTask(task: event.task);
    tasks
      ..addAll(event.tasks)
      ..add(event.task);
    emit(
      state.copyWith(
        tasks: tasks,
        isLoading: false,
      ),
    );
  }

  Future<void> _onRemoveTasks(
    MainPageEventRemoveTasks event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    List<TaskModel> tasks = [];
    tasks.addAll(event.tasks);
    final newList =
        tasks.where((element) => element.isCompleted == 'true').toList();
    await _repository.removeTasks(tasks: newList);
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].isCompleted == 'true') {
        tasks.removeAt(i);
        i--;
      }
    }
    emit(
      state.copyWith(
        tasks: tasks,
        isLoading: false,
      ),
    );
  }

  Future<void> _onChangeCompletedType(
    MainPageEventChangeCompletedType event,
    Emitter<MainPageState> emit,
  ) async {
    emit(
      state.copyWith(
        tasks: event.tasks,
        completedStatus: event.completedStatus,
      ),
    );
  }

  Future<void> _onMarkAllCompleted(
    MainPageEventMarkAllCompleted event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    List<TaskModel> tasks = [];
    tasks.addAll(event.tasks);
    for (int i = 0; i < tasks.length; i++) {
      tasks[i] = tasks[i].copyWith(isCompleted: 'true');
    }
    emit(
      state.copyWith(
        tasks: tasks,
        isLoading: false,
      ),
    );
  }

  Future<void> _onMarkTaskCompleted(
    MainPageEventMarkTaskCompleted event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    List<TaskModel> tasks = [];
    tasks.addAll(event.tasks);
    tasks[event.index] = tasks[event.index].copyWith(
      isCompleted: event.value.toString(),
    );
    emit(
      state.copyWith(
        tasks: tasks,
        isLoading: false,
      ),
    );
  }
}
