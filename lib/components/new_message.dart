import 'package:flutter/material.dart';
import 'package:chat/core/services/chat/chat_service.dart'; // Importe o serviço de tarefas.
import 'package:chat/core/services/auth/auth_service.dart';
class NewTask extends StatefulWidget {
  const NewTask({Key? key});

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String _description = '';
  final _descriptionController = TextEditingController();

  Future<void> _addTask() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await TaskService().save(_description, user); // Use o serviço de tarefas para salvar a nova tarefa.
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _descriptionController,
            onChanged: (description) => setState(() => _description = description),
            decoration: const InputDecoration(
              labelText: 'Adicionar Tarefa...',
            ),
            onSubmitted: (_) {
              if (_description.trim().isNotEmpty) {
                _addTask();
              }
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _description.trim().isEmpty ? null : _addTask,
        ),
      ],
    );
  }
}
