import 'package:flutter/material.dart';
import 'package:kanban_board/screens/kanban/components/store/kanban_store.dart';

class KanbanView extends StatelessWidget {
  final KanbanStore kanbanStore;
  const KanbanView({super.key, required this.kanbanStore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kanban Board'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          kanbanStore.buildTaskList(kanbanStore.todoTasks, 'Todo', context),
          const SizedBox(width: 16),
          kanbanStore.buildTaskList(
              kanbanStore.inProgressTasks, 'In Progress', context),
          const SizedBox(width: 16),
          kanbanStore.buildTaskList(
              kanbanStore.finishedTasks, 'Finished', context),
        ],
      ),
    );
  }
}
