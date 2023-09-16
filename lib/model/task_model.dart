import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  List<CategoryModel>? taskTypes;

  CategoryModel({required this.id, required this.taskTypes});

  CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        taskTypes = [];
}

class TaskModel {
  String id;
  List<TaskModel>? taskID;

  TaskModel({required this.id, required this.taskID});

  TaskModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        taskID = [];
}
