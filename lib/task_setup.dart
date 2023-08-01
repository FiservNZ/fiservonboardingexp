import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class TaskSetUp extends ChangeNotifier {
  var collection = FirebaseFirestore.instance.collection("Task");
  late List<Map<String, dynamic>> tasklist;

  fetchTasksFromFirestore() async {
    List<Map<String, dynamic>> tempList = [];
    var data = await collection.get();

    data.docs.forEach((element) {
      tempList.add(element.data());
    });
  }

  //list of tasks
  /*final List<Task> _tasklist = [
    //Task on setting up computer
    Task(
        name: "Your first week with us",
        type: "Read Time: 15 mins",
        content:
            "This task will go through what you should look to achieve in your first week with us",
        iconPath: "assets/icon/book.png"),

    Task(
        name: "Setting up your device",
        type: "Read Time: 30 mins",
        content:
            "This task will have step by step process on how to set up your work device",
        iconPath: "assets/icon/book.png"),
  ];*/

  /*Future<List<Task>> fetchTasksFromFirestore() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Task')
          .doc('gdrqBo6lTy1bDyoMVUkx')
          .get();

      String fname = snapshot.data()!['name'];
      String ftype = snapshot.data()!['type'];
      String fcontent = snapshot.data()!['content'];
      print('value added successfully: $fname');
      Task task = Task(
        name: fname,
        type: ftype,
        content: fcontent,
        iconPath: 'assets/icon/book.png',
      );
      print('constructor added successfully');
      print('constructor added successfully: $fname');
      print('constructor added successfully: $ftype');
      print('constructor added successfully: $fcontent');
      tasklist.add(task);

      notifyListeners();

      print('Task added successfully: $task');
      print('Updated tasklist: $tasklist');

      return tasklist;
    } catch (e) {
      print('Error fetching tasks: $e');
      return []; // Return an empty list on error, but you should handle errors more gracefully.
    }
  }

  //get tasks available
  List<Task> get getTaskList => tasklist;*/
}
