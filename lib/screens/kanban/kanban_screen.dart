import 'package:flutter/material.dart';
import 'package:kanban_board/screens/kanban/components/presenter/kanban_presenter.dart';

class KanbanScreen extends StatelessWidget {
  const KanbanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: KanbanPresenter(),
    );
  }
}
