import 'package:flutter/material.dart'; // Para construir a interface do usuário.
import 'package:chat/core/models/chat_message.dart'; // Para trabalhar com os modelos de tarefas.

class TaskEditScreen extends StatefulWidget {
  final Task task;
  final Function(Task) onTaskEdited;

  TaskEditScreen({
    Key? key,
    required this.task,
    required this.onTaskEdited,
  }) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título:'),
            TextField(controller: titleController),
            SizedBox(height: 16),
            Text('Descrição:'),
            TextField(controller: descriptionController),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Salvar as alterações na tarefa e chamar a função de retorno.
                Task updatedTask = widget.task.copyWith(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                widget.onTaskEdited(updatedTask);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
