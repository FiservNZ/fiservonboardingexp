import 'package:fiservonboardingexp/task.dart';
import 'package:flutter/material.dart';

class TaskSetUp extends ChangeNotifier {
  //list of tasks
  final List<Task> _tasklist = [
    //Task on setting up computer
    Task(
        name: "Your first week with us",
        type: "Read Time: 15 mins",
        iconPath: "assets/icon/book.png"),

    Task(
        name: "Setting up your device",
        type: "Read Time: 30 mins",
        iconPath: "assets/icon/book.png"),
  ];

  //get tasks available
  List<Task> get tasklist => _tasklist;

  //remove below when can
  final List<Task> _userCart = [];

  void addToPage(Task task) {
    _userCart.add(task);
    notifyListeners();
  }

  void removeFromPage(Task task) {
    _userCart.remove(task);
    notifyListeners();
  }
}
