import 'package:cloud_firestore/cloud_firestore.dart';

class WatchModel {
  String id;
  String category;
  String videoUrl;
  String videoTitle;
  String videoDescription;
  String popUpDescription;
  int exp;
  bool isDone;

  WatchModel(
      {
      //super.key,
      required this.id,
      required this.category,
      required this.videoTitle,
      required this.videoDescription,
      required this.videoUrl,
      required this.isDone,
      required this.popUpDescription,
      required this.exp});

  WatchModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        category = snapshot['category'],
        videoTitle = snapshot['videoTitle'],
        videoDescription = snapshot['videoDescription'],
        videoUrl = snapshot['videoUrl'],
        isDone = snapshot['isDone'] as bool,
        popUpDescription = snapshot['popUpDescription'],
        exp = snapshot['exp'] as int;
}
