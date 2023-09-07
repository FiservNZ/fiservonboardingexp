import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String? id;
  String firstName;
  String lastName;
  String position;
  String iconColor;
  String selectedIcon;

  String? interestingFacts;
  String? futureSelf;
  String? hobbies;

  int exp;
  int level;
  int maxEXP;
  //List<TaskModel>? tasks;
  //List<Checklist>? checklist;

  bool hasIntroduced;
  bool isFirstLog;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.iconColor,
    required this.selectedIcon,
    this.interestingFacts,
    this.futureSelf,
    this.hobbies,
    required this.exp,
    required this.level,
    required this.maxEXP,
    //this.tasks,
    //this.checklist,
    required this.hasIntroduced,
    required this.isFirstLog,
  });

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        firstName = snapshot['firstName'],
        lastName = snapshot['lastName'],
        position = snapshot['position'],
        iconColor = snapshot['iconColor'],
        selectedIcon = snapshot['selectedIcon'],
        interestingFacts = snapshot['Interesting Facts'],
        futureSelf = snapshot['Future Self'],
        hobbies = snapshot['Hobbies'],
        exp = snapshot['question_count'] as int,
        level = snapshot['Level'] as int,
        maxEXP = snapshot['MaxEXP'] as int,
        hasIntroduced = snapshot['introduced'] as bool,
        isFirstLog = snapshot['firstlog'] as bool;
  //tasks = [];
  //checklist = [];
}
