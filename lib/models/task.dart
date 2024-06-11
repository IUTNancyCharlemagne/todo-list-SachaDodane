class Task {
  int? id;
  String title;
  String content;
  bool completed;
  DateTime? dueDate;

  Task({
    this.id,
    required this.title,
    required this.content,
    required this.completed,
    this.dueDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'completed': completed,
      'due_date': dueDate?.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] != null ? json['id'] as int : null,
      title: json['title'] as String,
      content: json['content'] as String,
      completed: json['completed'] as bool,
      dueDate: json['due_date'] != null ? DateTime.parse(json['due_date']) : null,
    );
  }
}
