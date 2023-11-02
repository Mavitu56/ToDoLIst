import 'dart:async';
import 'package:chat/core/models/task.dart';
import 'package:chat/core/models/task_user.dart';
import 'package:chat/core/services/chat/task_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskFirebaseService implements TaskService {
  @override
  Stream<List<Task>> tasksStream() {
    return const Stream<List<Task>>.empty();
  }

  @override
  Future<Task?> save(String title, String description, DateTime? dueDate, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final task = Task(
      id: '',
      title: title,
      description: description,
      dueDate: dueDate,
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
      isCompleted: false,
    );

    final docRef = await store
        .collection('task')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(task);

    final doc = await docRef.get();
    return doc.data()!;
  }

  // Task => Map<String, dynamic>
  Map<String, dynamic> _toFirestore(
    Task task,
    SetOptions? options,
  ) {
    return {
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate?.toIso8601String(),
      'userId': task.userId,
      'userName': task.userName,
      'userImageUrl': task.userImageUrl,
      'isCompleted': task.isCompleted,
    };
  }

  // Map<String, dynamic> => Task
  Task _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return Task(
      id: doc.id,
      title: doc['title'],
      description: doc['description'],
      dueDate: DateTime.parse(doc['dueDate']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageUrl: doc['userImageUrl'],
      isCompleted: doc['isCompleted'],
    );
  }

  @override
  Future<void> edit(String taskId, String title, String description, DateTime? dueDate) async {
    final store = FirebaseFirestore.instance;
  
    // Obtenha a referência do documento que você deseja atualizar
    final docRef = store.collection('task').doc(taskId);

    // Atualize o documento
    await docRef.update({
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
    });
  }

  @override
  Future<void> delete(String taskId) async {
    final store = FirebaseFirestore.instance;
  
    // Obtenha a referência do documento que você deseja deletar
    final docRef = store.collection('task').doc(taskId);

    // Delete o documento
    await docRef.delete();
  }
}