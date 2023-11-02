import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/task.dart';
import 'package:chat/core/models/task_user.dart';
import 'package:chat/core/services/chat/task_service.dart';
class TaskMockService implements TaskService {
  static final List<Task> _tasks = [];

  static MultiStreamController<List<Task>>? _controller;
  static final _tasksStream = Stream<List<Task>>.multi((controller) {
    _controller = controller;
    controller.add(_tasks);
  });

  @override
  Stream<List<Task>> tasksStream() {
    return _tasksStream;
  }

  @override
  Future<Task> save(String title, String description, DateTime? dueDate, ChatUser user) async {
  final newTask = Task(
      id: Random().nextDouble().toString(),
      userName: user.name,
      title: title,
      userImageUrl: user.imageUrl,
      description: description,
      dueDate: dueDate,
      userId: user.id,
      isCompleted: false, // Defina a tarefa como não concluída por padrão.
    );
    _tasks.add(newTask);
    _controller?.add(_tasks.reversed.toList());
    return newTask;
  }

   @override
Future<void> edit(String taskId, String title, String description, DateTime? dueDate) async {
  final task = _tasks.firstWhere(
    (t) => t.id == taskId,
    orElse: () => Task(
      id: '',
      userName: '',
      title: '',
      userImageUrl: '',
      description: '',
      dueDate: null,
      userId: '',
      isCompleted: false,
    ),
  );

  if (task.id.isNotEmpty) {
    task.title = title;
    task.description = description;
    task.dueDate = dueDate;
    _controller?.add(_tasks.reversed.toList()); // Adicione esta linha
  }
}

@override
Future<void> delete(String taskId) async {
  _tasks.removeWhere((t) => t.id == taskId);
  _controller?.add(_tasks.reversed.toList()); // Adicione esta linha
}
}