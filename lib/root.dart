import 'package:flutter/material.dart';
import 'package:notes_app/app/home_screen.dart';
import 'package:notes_app/theme.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = NotesAppTheme.lightTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
