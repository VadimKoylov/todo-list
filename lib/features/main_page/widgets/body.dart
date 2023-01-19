import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/extencion/build_context_extencion.dart';
import 'package:todo/core/utils/format_tasks.dart';
import 'package:todo/features/app/components/components.dart';
import 'package:todo/features/main_page/bloc/main_page_bloc.dart';
import 'package:todo/features/main_page/entities/task_model.dart';
import 'package:todo/features/main_page/widgets/loading.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        List<TaskModel> tasks = [];
        if (state.tasksBox != null) {
          tasks = FormatTasks.getTasks(
            state.tasksBox!,
            state.completedStatus,
          );
        }
        return state.isLoading || state.tasksBox == null
            ? const Loading()
            : Container(
                color: context.appColors.mainGrey,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AppCheckboxListTile(
                      title: tasks[index].title,
                      description: tasks[index].body,
                      onChanged: (value) {
                        context.read<MainPageBloc>().add(
                              MainPageEventMarkTaskCompleted(
                                tasksBox: state.tasksBox!,
                                index: index,
                                value: value ?? false,
                              ),
                            );
                      },
                      checkboxListTileStyle: CheckboxListTileStyle(
                        textStyle: tasks[index].isCompleted == 'true'
                            ? context.appTextStyles.inter14LineThrough.copyWith(
                                decorationThickness: 2,
                              )
                            : context.appTextStyles.inter14Reg,
                      ),
                      initialValue: tasks[index].isCompleted == 'true',
                    );
                  },
                ),
              );
      },
    );
  }
}
