import 'package:flutter/material.dart';
import 'package:kanban_board/screens/kanban/kanban_screen.dart';

class KanbanApp extends StatelessWidget {
  const KanbanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban Board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KanbanScreen(),
    );
  }
}