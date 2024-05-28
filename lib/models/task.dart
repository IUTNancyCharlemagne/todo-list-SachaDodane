
class Task {
  final int? id;
  final String content;
  late bool completed;
  final String title;
  Task({
    this.id,
    required this.content,
    required this.completed,
    required this.title,
  });
}
