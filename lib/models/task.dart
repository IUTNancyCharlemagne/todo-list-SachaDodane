class Task {
  int? id;
  String title;
  String content;
  bool completed;

  Task({
    this.id,
    required this.title,
    required this.content,
    required this.completed,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'completed': completed,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] != null ? json['id'] as int : null,
      title: json['title'] as String,
      content: json['content'] as String,
      completed: json['completed'] as bool,
    );
  }
}
