import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_mock_service.dart';

abstract class TaskService {
  Stream<List<Task>> tasksStream();
  Future<Task> save(String title, String description, DateTime? dueDate, ChatUser user);
  Future<void> edit(String taskId, String title, String description, DateTime? dueDate);
  Future<void> delete(String taskId);

  factory TaskService() {
    return TaskMockService();
  }
}
