import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase references/firebase_refs.dart';
import '../model/user.dart';

class ManagerController extends GetxController {
  late UserModel userModel;
  final allUsers = <UserModel>[].obs;

  @override
  void onReady() {
    //final quizQuestion = Get.arguments as QuizModel;
    //print(quizQuestion.id);
    //loadData(quizQuestion);
    loadUserDetails(userModel);
    super.onReady();
  }

  // loads data from the database
  Future<void> loadUserDetails(UserModel userInfo) async {
    userInfo = userModel;
    try {
      QuerySnapshot<Map<String, dynamic>> userData = await userColRef.get();
      final userList =
          userData.docs.map((user) => UserModel.fromSnapshot(user)).toList();
      allUsers.assignAll(userList);
    } catch (e) {
      debugPrint('Exception Found: $e');
    }
  }
}
