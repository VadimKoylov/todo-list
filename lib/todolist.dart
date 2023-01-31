import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/theme/app_theme.dart';
import 'package:todo/features/main_page/presentation/bloc/main_page_bloc.dart';
import 'package:todo/features/main_page/presentation/main_page.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      home: BlocProvider(
        create: (context) => MainPageBloc(),
        child: MainPage(),
      ),
    );
  }
}