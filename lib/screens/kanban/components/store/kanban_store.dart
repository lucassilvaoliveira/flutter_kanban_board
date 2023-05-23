import 'package:flutter/material.dart';
import 'package:kanban_board/core/entities/task.dart';
import 'package:kanban_board/global/constants.dart';

class KanbanStore extends ChangeNotifier {
  List<Task> todoTasks = [
    Task(id: uuid.v4(), title: "Task 1"),
    Task(id: uuid.v4(), title: "Task 2"),
    Task(id: uuid.v4(), title: "Task 3")
  ];

  List<Task> inProgressTasks = [Task(id: uuid.v4(), title: "Task 4")];

  List<Task> finishedTasks = [];

  String newTaskTitle = "";

  void showAddTaskModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              newTaskTitle = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter task name',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                todoTasks.add(Task(id: uuid.v4(), title: newTaskTitle));
                notifyListeners();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildTaskItem(Task task, String sourceListName) {
    return Draggable(
      data: {'task': task, 'sourceList': sourceListName},
      feedback: Material(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(task.title),
          ),
        ),
      ),
      childWhenDragging: Container(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(task.title),
        ),
      ),
    );
  }

  Widget buildTaskList(
      List<Task> tasks, String listName, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: size.height * .1,
            color: Colors.grey[300],
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (listName == 'Todo')
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showAddTaskModal(context);
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            child: DragTarget<Map>(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return buildTaskItem(task, listName);
                  },
                );
              },
              onAccept: (data) {
                final sourceListName = data['sourceList'];
                final destinationList = listName == 'Todo'
                    ? todoTasks
                    : (listName == 'In Progress'
                        ? inProgressTasks
                        : finishedTasks);
                final task = data['task'];
                final sourceList = sourceListName == 'Todo'
                    ? todoTasks
                    : (sourceListName == 'In Progress'
                        ? inProgressTasks
                        : finishedTasks);
                sourceList.remove(task);
                destinationList.add(task);
                notifyListeners();
              },
            ),
          ),
        ],
      ),
    );
  }
}
