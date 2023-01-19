part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  const MainPageState({
    this.isLoading = true,
    this.tasksBox,
    this.completedStatus = Completed.all,
  });

  final bool isLoading;
  final Box<TaskModel>? tasksBox;
  final Completed completedStatus;

  MainPageState copyWith({
    bool? isLoading,
    Box<TaskModel>? tasksBox,
    Completed? completedStatus,
  }) {
    return MainPageState(
      isLoading: isLoading ?? this.isLoading,
      tasksBox: tasksBox ?? this.tasksBox,
      completedStatus: completedStatus ?? this.completedStatus,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        tasksBox,
        completedStatus,
      ];
}
