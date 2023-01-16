part of 'main_page_bloc.dart';

class MainPageState extends Equatable {
  const MainPageState({
    this.isLoading = true,
    this.tasks = const [],
    this.completedStatus = Completed.all,
  });

  final bool isLoading;
  final List<TaskModel> tasks;
  final Completed completedStatus;

  MainPageState copyWith({
    bool? isLoading,
    List<TaskModel>? tasks,
    Completed? completedStatus,
  }) {
    return MainPageState(
      isLoading: isLoading ?? this.isLoading,
      tasks: tasks ?? this.tasks,
      completedStatus: completedStatus ?? this.completedStatus,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        tasks,
        completedStatus,
      ];
}
