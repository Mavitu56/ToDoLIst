class Task {

  final String id;
  final String title; // Novo campo "title"
  final String description;
  final DateTime? dueDate;
  final bool isCompleted;  

  final String userId;
  final String userName;
  final String userImageUrl;

  const Task({
    required this.id,
    required this.description,
    required this.title,
    required this.dueDate,
    required this.isCompleted,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });
}