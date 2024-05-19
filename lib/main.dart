// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/shared/bloc_observer.dart';

Future main() async {
  Bloc.observer = MyBlocObserver();

// Initialize FFI
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do',
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            // ···
            brightness: Brightness.dark),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}
