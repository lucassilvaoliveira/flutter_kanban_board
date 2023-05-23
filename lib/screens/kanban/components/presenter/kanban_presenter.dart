import 'package:flutter/material.dart';
import 'package:kanban_board/screens/kanban/components/store/kanban_store.dart';
import 'package:kanban_board/screens/kanban/components/view/kanban_view.dart';

class KanbanPresenter extends StatefulWidget {
  const KanbanPresenter({super.key});

  @override
  State<KanbanPresenter> createState() => _KanbanPresenterState();
}

class _KanbanPresenterState extends State<KanbanPresenter> {
  late KanbanStore kanbanStore;

  @override
  void initState() {
    super.initState();
    kanbanStore = KanbanStore();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: kanbanStore,
      builder: (context, child) => KanbanView(kanbanStore: kanbanStore),
    );
  }
}
