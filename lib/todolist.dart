import 'package:flutter/material.dart';
import 'package:todo/features/app/theme/app_theme.dart';
import 'package:todo/features/main_page/widgets/main_page.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.themeData,
      home: const MainPage(),
    );
  }
}