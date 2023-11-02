import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat/pages/TaskEditScreen.dart';
class TaskTile extends StatefulWidget {
  final Task task;
  final bool belongsToCurrentUser;
  final TaskService taskManager;

  const TaskTile({
    Key? key,
    required this.task,
    required this.belongsToCurrentUser,
    required this.taskManager,
  }) : super(key: key);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final formattedDate = widget.task.dueDate != null
        ? DateFormat('dd/MM/yyyy').format(widget.task.dueDate!)
        : 'N/A';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.task.title,
              style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? Colors.grey : Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  'Data: $formattedDate',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 8),
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) {
                    setState(() {
                      isCompleted = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descrição: ${widget.task.description}',
                  style: TextStyle(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? Colors.grey : Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.taskManager.delete(widget.task.id);
                        setState(() {}); // Adicione esta linha
                      },
                      icon: Icon(Icons.delete), // Ícone de exclusão
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        _editTask(context);
                        setState(() {}); // Adicione esta linha
                      },
                      icon: Icon(Icons.edit), // Ícone de edição
                    ),

                  ],
                ),
              ],
            ),
        ),
        ],
      ),
    );
  }

  void _editTask(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(
          task: widget.task,
          onTaskEdited: (updatedTask) {
            widget.taskManager.edit(
              updatedTask.id,
              updatedTask.title,
              updatedTask.description,
              updatedTask.dueDate,
            );
          },
        ),
      ),
    );
  }
}

