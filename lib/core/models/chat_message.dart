class Task {

  final String id;
  final String description;
  final DateTime createdAt;
  final bool isCompleted;  

  final String userId;
  final String userName;
  final String userImageUrl;

  const Task({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.isCompleted,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });
}