import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/features/main_page/entities/task.dart';
import 'package:todo/features/main_page/repository/main_page_repository.dart';

part 'main_page_bloc.freezed.dart';

@freezed
class MainPageEvent with _$MainPageEvent {
  const MainPageEvent._();

  const factory MainPageEvent.readTasks() = _ReadTasksMainPageEvent;

  const factory MainPageEvent.writeTask({
    required Task task,
  }) = _WriteTaskMainPageEvent;

  const factory MainPageEvent.removeTasks({
    required List<Task> tasks,
  }) = _DeleteTasksMainPageEvent;
}

@freezed
class MainPageState with _$MainPageState {
  const MainPageState._();

  const factory MainPageState.loading() = _LoadingMainPageState;

  const factory MainPageState.loaded() = _LoadedMainPageState;

  const factory MainPageState.error({
    required final String message,
  }) = _ErrorMainPageState;
}

class MainPageBloc extends Bloc<MainPageEvent, MainPageState>
    implements EventSink<MainPageEvent> {
  MainPageBloc({
    required final IMainPageRepository repository,
  })  : _repository = repository,
        super(const MainPageState.loading()) {
    on<MainPageEvent>(
      (event, emit) => event.map<Future<void>>(
        readTasks: (event) => _readTasks(event, emit),
        writeTask: (event) => _writeTask(event, emit),
        removeTasks: (event) => _removeTasks(event, emit),
      ),
      transformer: bloc_concurrency.concurrent(),
    );
  }

  final IMainPageRepository _repository;

  List<Task> tasks = [];

  Future<void> _readTasks(
    _ReadTasksMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(const MainPageState.loading());
    tasks = await _repository.readTasks();
    emit(const MainPageState.loaded());
  }

  Future<void> _writeTask(
    _WriteTaskMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(const MainPageState.loading());
    await _repository.writeTask(task: event.task);
    tasks.add(event.task);
    emit(const MainPageState.loaded());
  }

  Future<void> _removeTasks(
    _DeleteTasksMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(const MainPageState.loading());
    final newList =
        event.tasks.where((element) => element.isCompleted == 'true').toList();
    await _repository.removeTasks(tasks: newList);
    for (int i = 0; i < event.tasks.length; i++) {
      if (event.tasks[i].isCompleted == 'true') {
        tasks.removeAt(i);
      }
    }
    emit(const MainPageState.loaded());
  }
}
