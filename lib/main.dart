

import 'package:flutter/material.dart';
import 'package:sqflite_flutter/add_notes.dart';
import 'package:sqflite_flutter/home.dart';
import 'package:sqflite_flutter/show_screen.dart';
import 'package:sqflite_flutter/sqliteDb.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      routes: {
        'addNotes':(context)=>AddNotes(),
        'showNotes':(context)=>ShowScreen()
      },
    );
  }
}
