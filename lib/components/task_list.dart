import 'package:chat/components/Task_tile.dart';
import 'package:chat/core/models/task.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/task_service.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  final TaskService taskService = TaskService();
  final List<Key> taskTileKeys = []; // Crie uma lista de chaves.

  TaskList({Key? key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<Task>>(
      stream: taskService.tasksStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Sem Tarefas Hoje!',  style: TextStyle(color: Colors.white),
));
        } else {
          final tasks = snapshot.data!;

          return ListView.builder(
            reverse: true,
            itemCount: tasks.length,
            itemBuilder: (ctx, i) {
              // Use uma chave única para cada TaskTile.
              if (i >= taskTileKeys.length) {
                taskTileKeys.add(ValueKey(tasks[i].id));
              }
              return TaskTile(
                key: taskTileKeys[i],
                task: tasks[i],
                belongsToCurrentUser: currentUser?.id == tasks[i].userId,
                taskManager: taskService,
              );
            },
          );
        }
      },
    );
  }
}
