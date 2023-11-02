import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_mock_service.dart';

abstract class TaskService {
  Stream<List<Task>> tasksStream(); // Atualize o tipo de retorno para Task.
  Future<Task> save(String title, String description, DateTime? dueDate, ChatUser user); // Atualize o nome do parâmetro 'texto' para 'description'.

  factory TaskService() {
    return TaskMockService(); // Atualize a instância do serviço para TaskMockService.
  }
}