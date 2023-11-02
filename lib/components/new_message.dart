import 'package:flutter/material.dart';
import 'package:chat/core/services/chat/chat_service.dart'; // Importe o serviço de tarefas.
import 'package:chat/core/services/auth/auth_service.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key});

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  String _title = '';
  String _description = '';
  DateTime? _dueDate;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _addTask() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await TaskService().save(_title, _description, _dueDate, user); // Use o serviço de tarefas para salvar a nova tarefa.
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _dueDate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350, // Largura do input
          child: TextField(
            controller: _titleController,
            onChanged: (title) => setState(() => _title = title),
            decoration: const InputDecoration(
              labelText: 'Título da Tarefa',
              labelStyle: TextStyle(
      color: Colors.white, // Isso fará com que a cor do rótulo seja branca.
    ),
    enabledBorder: UnderlineInputBorder(      
      borderSide: BorderSide(color: Colors.white), // Isso fará com que a cor da linha seja branca quando o campo estiver habilitado.
    ), 
            ),
          ),
        ),
        Container(
          width: 350, // Largura do botão da data
          child: TextField(
            controller: _descriptionController,
            onChanged: (description) => setState(() => _description = description),
             decoration: const InputDecoration(
              labelText: 'Descrição da Tarefa',
              labelStyle: TextStyle(
      color: Colors.white, // Isso fará com que a cor do rótulo seja branca.
    ),
    enabledBorder: UnderlineInputBorder(      
      borderSide: BorderSide(color: Colors.white), // Isso fará com que a cor da linha seja branca quando o campo estiver habilitado.
    ), 
            ),
          ),
        ),
        const SizedBox(height: 16), // Espaço entre os elementos
        Container(
          width: 150, // Largura do botão da data
          decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10), // Isso fará com que as bordas fiquem arredondadas.
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.purple[800]!, Colors.purple[900]!],
    ),
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      onPrimary: Colors.white,
      shadowColor: Colors.transparent,
    ),
            onPressed: () => _selectDueDate(context),
            child: const Text('Selecionar Data'),
          ),
        ),
        const SizedBox(height: 16), // Espaço entre os elementos
        Container(
          width: 60, // Largura do botão de adicionar
          decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10), // Isso fará com que as bordas fiquem arredondadas.
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.purple[800]!, Colors.purple[900]!],
    ),
  ),
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      onPrimary: Colors.white,
      shadowColor: Colors.transparent,
    ),
            onPressed: _title.trim().isEmpty ? null : _addTask,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add),
              ],
            ),
          ),
        ),
                SizedBox(height: 16), // Espaço entre os elementos
      ],
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }
}
