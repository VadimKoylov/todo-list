import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/database/app_database.dart';
import 'package:todo/core/extencion/build_context_extencion.dart';
import 'package:todo/features/app/components/components.dart';
import 'package:todo/features/app/components/widgets/modal_bootom_sheet.dart';
import 'package:todo/features/main_page/bloc/main_page_bloc.dart';
import 'package:todo/features/main_page/entities/task.dart';
import 'package:todo/features/main_page/repository/main_page_repository.dart';
import 'package:todo/features/main_page/widgets/app_popup_menu_button.dart';
import 'package:todo/features/main_page/widgets/body.dart';
import 'package:todo/features/main_page/widgets/loading.dart';
import 'package:todo/main.dart';
import 'package:uuid/uuid.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  late MainPageBloc _bloc;
  List<Task>? tasks;
  Completed completed = Completed.all;

  @override
  void initState() {
    super.initState();
    _bloc = MainPageBloc(
      repository: MainPageRepository(
        database: AppDatabase(database: appDatabase),
      ),
    )..add(const MainPageEvent.readTasks());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainPageBloc>(
      create: (context) => _bloc,
      child: Scaffold(
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
                    completed = Completed.all;
                    tasks = _bloc.tasks;
                    setState(() {});
                    break;
                  case 'Show activity':
                    completed = Completed.activity;
                    tasks = _bloc.tasks
                        .where((element) => element.isCompleted == 'false')
                        .toList();
                    setState(() {});
                    break;
                  case 'Show completed':
                    completed = Completed.completed;
                    tasks = _bloc.tasks
                        .where((element) => element.isCompleted == 'true')
                        .toList();
                    setState(() {});
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
                    for (int i = 0; i < _bloc.tasks.length; i++) {
                      _bloc.tasks[i] =
                          _bloc.tasks[i].copyWith(isCompleted: 'true');
                    }
                    setState(() {});
                    break;
                  case 'Clear completed':
                    _bloc.add(MainPageEvent.removeTasks(tasks: _bloc.tasks));
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
        body: BlocBuilder<MainPageBloc, MainPageState>(
          bloc: _bloc,
          builder: (context, state) => state.when(
            loading: () => const Loading(),
            loaded: () => Body(tasks: tasks ?? _bloc.tasks),
            error: (e) => Center(
              child: Text(e.toString()),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            AppModalBottomSheet.modalBottomSheet(
              context,
              titleController: titleController,
              bodyController: bodyController,
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  _bloc.add(
                    MainPageEvent.writeTask(
                      task: Task(
                        id: const Uuid().v4(),
                        title: titleController.text,
                        body: bodyController.text,
                        isCompleted: 'false',
                      ),
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
      ),
    );
  }
}

enum Completed { all, activity, completed }
