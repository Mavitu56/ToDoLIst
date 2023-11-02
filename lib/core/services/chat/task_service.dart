import 'package:chat/core/models/task.dart';
import 'package:chat/core/models/task_user.dart';
import 'package:chat/core/services/chat/task_firebase_service.dart';

abstract class TaskService {
  Stream<List<Task>> tasksStream();
  Future<Task?> save(String title, String description, DateTime? dueDate, ChatUser user);
  Future<void> edit(String taskId, String title, String description, DateTime? dueDate);
  Future<void> delete(String taskId);

  factory TaskService() {
    return TaskFirebaseService();
  }
}
