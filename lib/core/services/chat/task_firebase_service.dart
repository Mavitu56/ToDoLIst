import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/task.dart';
import 'package:chat/core/models/task_user.dart';
import 'package:chat/core/services/chat/task_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskFirebaseService implements TaskService {
  final store = FirebaseFirestore.instance;

  @override
  Stream<List<Task>> tasksStream() {
    return store.collection('tasks').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task.fromMap(doc.data());
      }).toList();
    });
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

    await store.collection('tasks').doc(newTask.id).set(newTask.toMap());

    return newTask;
  }

  @override
  Future<void> edit(String taskId, String title, String description, DateTime? dueDate) async {
    await store.collection('tasks').doc(taskId).update({
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
    });
  }

  @override
  Future<void> delete(String taskId) async {
    await store.collection('tasks').doc(taskId).delete();
  }
}
