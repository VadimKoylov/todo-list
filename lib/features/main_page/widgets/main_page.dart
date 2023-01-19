import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/extencion/build_context_extencion.dart';
import 'package:todo/features/app/components/components.dart';
import 'package:todo/features/app/components/widgets/modal_bootom_sheet.dart';
import 'package:todo/features/main_page/bloc/main_page_bloc.dart';
import 'package:todo/features/main_page/entities/task_model.dart';
import 'package:todo/features/main_page/widgets/app_popup_menu_button.dart';
import 'package:todo/features/main_page/widgets/body.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    final bloc = context.read<MainPageBloc>();
    bloc.add(MainPageEventReadTasks());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: context.appColors.mainGrey,
        actions: [
          AppPopupMenuButton(
            icon: const Icon(Icons.sort_rounded),
            items: const {
              'Show all',
              'Show activity',
              'Show completed',
            },
            onSelected: (value) {
              switch (value) {
                case 'Show all':
                  if (bloc.state.tasksBox != null) {
                    bloc.add(
                      MainPageEventChangeCompletedType(
                        completedStatus: Completed.all,
                        tasksBox: bloc.state.tasksBox!,
                      ),
                    );
                  }
                  break;
                case 'Show activity':
                  if (bloc.state.tasksBox != null) {
                    bloc.add(
                      MainPageEventChangeCompletedType(
                        completedStatus: Completed.activity,
                        tasksBox: bloc.state.tasksBox!,
                      ),
                    );
                  }
                  break;
                case 'Show completed':
                  if (bloc.state.tasksBox != null) {
                    bloc.add(
                      MainPageEventChangeCompletedType(
                        completedStatus: Completed.completed,
                        tasksBox: bloc.state.tasksBox!,
                      ),
                    );
                  }
                  break;
              }
            },
          ),
          AppPopupMenuButton(
            icon: const Icon(Icons.more_horiz_outlined),
            items: const {
              'Mark all completed',
              'Clear completed',
            },
            onSelected: (value) {
              switch (value) {
                case 'Mark all completed':
                  if (bloc.state.tasksBox != null) {
                    bloc.add(
                      MainPageEventMarkAllCompleted(
                        tasksBox: bloc.state.tasksBox!,
                      ),
                    );
                  }
                  break;
                case 'Clear completed':
                  if (bloc.state.tasksBox != null) {
                    bloc.add(
                      MainPageEventRemoveTasks(
                        tasksBox: bloc.state.tasksBox!,
                      ),
                    );
                  }
                  AppSnackBar.showSnackBar(
                    context,
                    message: 'Tasks removed',
                  );
                  break;
              }
            },
          ),
        ],
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: context.appColors.mainBlack,
            width: 2,
          ),
        ),
        backgroundColor: context.appColors.white24,
        child: const Icon(Icons.add),
        onPressed: () {
          AppModalBottomSheet.modalBottomSheet(
            context,
            titleController: titleController,
            bodyController: bodyController,
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  bloc.state.tasksBox != null) {
                bloc.add(
                  MainPageEventWriteTasks(
                    task: TaskModel(
                      title: titleController.text,
                      body: bodyController.text,
                      isCompleted: 'false',
                    ),
                    tasksBox: bloc.state.tasksBox!,
                  ),
                );
              }
              titleController.clear();
              bodyController.clear();
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}

enum Completed { all, activity, completed }
