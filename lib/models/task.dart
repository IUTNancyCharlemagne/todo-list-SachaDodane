
class Task {
  final int? id;
  late final String content;
  late bool completed;
  late final String title;
  Task({
    this.id,
    required this.content,
    required this.completed,
    required this.title,
  });
}
