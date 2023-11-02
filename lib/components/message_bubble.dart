import 'dart:io';

import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final bool belongsToCurrentUser;

  const TaskTile({
    Key? key,
    required this.task,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card( // Usar um Card para criar o retângulo.
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile( // Usar ExpansionTile para expandir/contrair informações.
        title: Text(task.description), // Exibir o título da tarefa.

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Data: ${task.createdAt.toString()}'), // Exibir informações adicionais, como data.
                Text('Descrição: ${task.description}'), // Exibir descrição da tarefa.
              ],
            ),
          ),
        ],
      ),
    );
  }
}
