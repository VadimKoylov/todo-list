import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/todolist.dart';

late Database appDatabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appDatabase = await initDatabase();
  runApp(const Todolist());
}

Future<Database> initDatabase() async {
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'tasks');

  if (!await Directory(dirname(path)).exists()) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      log(e.toString());
    }
  }
  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE tasks (id TEXT PRIMARY KEY, title TEXT, body TEXT, isCompleted TEXT)',
      );
    },
  );
  return database;
}
