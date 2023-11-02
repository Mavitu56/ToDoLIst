class Task {

  final String id;
  String title; 
  String description;
  DateTime? dueDate;
  final bool isCompleted;  

  final String userId;
  final String userName;
  String userImageUrl;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'title': title,
      'userImageUrl': userImageUrl,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'userId': userId,
      'isCompleted': isCompleted,
    };
  }

  // Cria um objeto Task a partir de um Map
  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      userName: map['userName'],
      title: map['title'],
      userImageUrl: map['userImageUrl'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      userId: map['userId'],
      isCompleted: map['isCompleted'],
    );
  }

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
