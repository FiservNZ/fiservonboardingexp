class ReadModel {
  final String id;
  final String title;
  final String description;
  final String content;
  final int time;
  bool isDone;

  ReadModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.time,
    required this.isDone,
  });
}
