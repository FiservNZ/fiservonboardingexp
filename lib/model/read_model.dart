class ReadModel {
  final String id;
  final String title;
  final String description;
  final String content;
  final String time;
  String? imageUrl;
  bool isDone;

  ReadModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.time,
    required this.isDone,
    required this.imageUrl,
  });
}
