import 'dart:io';

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
  static const _defaultImage = 'assets/images/avatar.png';
  Widget _showUserImage (String imageUrl){
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }
    return CircleAvatar( backgroundImage: provider,);
  }
  @override
  Widget build(BuildContext context) {
    final formattedDate = widget.task.dueDate != null
        ? DateFormat('dd/MM/yyyy').format(widget.task.dueDate!)
        : 'N/A';

return Stack(
  children: [
    Padding(
      padding: const EdgeInsets.only(top: 30.0), // Adicione padding no topo para evitar que a imagem seja cortada.
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple[800]!, Colors.purple[900]!],
            ),
          ),
          child: ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.task.title,
                    style: TextStyle(
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                      color: isCompleted ? Colors.grey : Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Data: $formattedDate',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Container(
                        color:
                            Colors.transparent, // Defina a cor desejada como fundo do Container
                        child: Checkbox(
                          value: isCompleted,
                          onChanged: (value) {
                            setState(() {
                              isCompleted = value!;
                            });
                          },
                        ),
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
                          decoration:
                              isCompleted ? TextDecoration.lineThrough : null,
                          color: isCompleted ? Colors.grey : Colors.white,
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
                            icon:
                                Icon(Icons.delete, color:
                                    Colors.white), // Ícone de exclusão
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              _editTask(context);
                              setState(() {}); // Adicione esta linha
                            },
                            icon:
                                Icon(Icons.edit, color:
                                    Colors.white), // Ícone de edição
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    ),
    Positioned(
      top: 5, // Ajuste este valor para mover a imagem para cima.
      left: 0,
      child: _showUserImage(widget.task.userImageUrl),
    ),
        ],
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

