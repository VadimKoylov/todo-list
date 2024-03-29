import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/enums/completed_status.dart';
import 'package:todo/features/main_page/data/repository/main_page_repository.dart';
import 'package:todo/features/main_page/domain/entity/entities.dart';

part 'main_page_event.dart';

part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(const MainPageState()) {
    on<MainPageEventReadTasks>(_onReadTasks);
    on<MainPageEventWriteTasks>(_onWriteTasks);
    on<MainPageEventRemoveTasks>(_onRemoveTasks);
    on<MainPageEventRemoveTask>(_onRemoveTask);
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
    final tasksBox = _repository.readBox();
    emit(
      state.copyWith(
        tasksBox: tasksBox,
        isLoading: false,
      ),
    );
  }

  Future<void> _onWriteTasks(
    MainPageEventWriteTasks event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    event.tasksBox.add(event.task);
    emit(
      state.copyWith(
        tasksBox: event.tasksBox,
        isLoading: false,
      ),
    );
  }

  Future<void> _onRemoveTasks(
    MainPageEventRemoveTasks event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final newTasksBox = await _repository.removeTasks(tasksBox: event.tasksBox);
    emit(
      state.copyWith(
        tasksBox: newTasksBox,
        isLoading: false,
      ),
    );
  }

  Future<void> _onRemoveTask(
    MainPageEventRemoveTask event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final newTasksBox = await _repository.removeTask(
      tasksBox: event.tasksBox,
      taskIndex: event.taskIndex,
    );
    emit(
      state.copyWith(
        tasksBox: newTasksBox,
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
        tasksBox: event.tasksBox,
        completedStatus: event.completedStatus,
      ),
    );
  }

  Future<void> _onMarkAllCompleted(
    MainPageEventMarkAllCompleted event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    for (int i = 0; i < event.tasksBox.length; i++) {
      event.tasksBox.values.toList()[i].isCompleted = 'true';
    }
    emit(
      state.copyWith(
        tasksBox: event.tasksBox,
        isLoading: false,
      ),
    );
  }

  Future<void> _onMarkTaskCompleted(
    MainPageEventMarkTaskCompleted event,
    Emitter<MainPageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    event.tasksBox.values.toList()[event.index].isCompleted =
        event.value.toString();
    emit(
      state.copyWith(
        tasksBox: event.tasksBox,
        isLoading: false,
      ),
    );
  }
}
