class Task {

  final String id;
  String title; 
  String description;
  DateTime? dueDate;
  final bool isCompleted;  

  final String userId;
  final String userName;
  final String userImageUrl;

   Task({
    required this.id,
    required this.description,
    required this.title,
    required this.dueDate,
    required this.isCompleted,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });

  Task copyWith({
    String? id,
    String? userName,
    String? title,
    String? userImageUrl,
    String? description,
    DateTime? dueDate,
    String? userId,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      title: title ?? this.title,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      userId: userId ?? this.userId,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
