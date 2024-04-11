import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hivedb/home_screen.dart';
import 'package:hivedb/todo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // Register Adapter
  Hive.registerAdapter(TodoAdapter());
  // open new box with Todo Datatype
  await Hive.openBox<Todo>('todo');
  // Just for Demo
  await Hive.openBox('friend');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: false,
        ),
        home: const HomeScreen());
  }
}
