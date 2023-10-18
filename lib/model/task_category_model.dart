import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/model/quiz_model.dart';
import 'package:fiservonboardingexp/model/read_model.dart';

// document
class TaskCategoryModel {
  String id;
  String title;
  int curPoints;
  int maxPoints;
  List<QuizModel>? quiz;
  List<ReadModel>? read;

  TaskCategoryModel(
      {required this.id,
      required this.title,
      required this.curPoints,
      required this.maxPoints,
      this.quiz,
      this.read});

  TaskCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        title = snapshot['title'] as String,
        curPoints = snapshot['curPoints'] as int,
        maxPoints = snapshot['maxPoints'] as int,
        quiz = [],
        read = [];
}
