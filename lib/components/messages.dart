import 'package:chat/components/message_bubble.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return StreamBuilder<List<Task>>(
      stream: TaskService().tasksStream(), // Use o serviço de tarefas aqui.
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Sem Tarefas Hoje!'));
        } else {
          final tasks = snapshot.data!;

          return ListView.builder(
            reverse: true,
            itemCount: tasks.length,
            itemBuilder: (ctx, i) => TaskTile( // Renomeei de MessageBubble para TaskTile.
              key: ValueKey(tasks[i].id),
              task: tasks[i],
              belongsToCurrentUser: currentUser?.id == tasks[i].userId,
            ),
          );
        }
      },
    );
  }
}
