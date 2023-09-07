import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadModel {
  String id;
  String title;
  String content;

  ReadModel({required this.id, required this.title, required this.content});

  // Converts JSON data into a ReadModel object
  ReadModel.fromJSON(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        content = json['content'] as String;

  // Converts data from Firebase into Map
  ReadModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        title = snapshot['title'],
        content = snapshot['content'];

  // Converts the properties of the QuizModel object into JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> readModelData = <String, dynamic>{};
    readModelData['id'] = id;
    readModelData['title'] = title;
    readModelData['content'] = content;
    return readModelData;
  }
}
