import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/model/quiz_model.dart';
import 'package:fiservonboardingexp/model/read_model.dart';

// document
class TaskCategoryModel {
  String id;
  int curPoints;
  int maxPoints;
  bool categoryCompletion;
  List<TaskCategoryModel>? taskTypes;

  TaskCategoryModel(
      {required this.id,
      this.taskTypes,
      required this.curPoints,
      required this.maxPoints,
      required this.categoryCompletion});

  TaskCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        curPoints = snapshot['curPoints'] as int,
        maxPoints = snapshot['maxPoints'] as int,
        categoryCompletion = ['categoryCompletion'] as bool,
        taskTypes = [];
}

// collection
class TaskModel {
  String id;
  List<QuizModel>? quiz;
  List<ReadModel>? read;
  //List<WatchModel> watch;

  TaskModel({required this.id, this.quiz, this.read});

  TaskModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        quiz = [],
        read = [];
  //watch = [];
}
