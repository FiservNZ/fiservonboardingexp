import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/model/task_category_model.dart';
import 'package:fiservonboardingexp/model/video_model.dart';
import 'package:fiservonboardingexp/model/watch_model.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/quiz_model.dart';
import '../util/constants.dart';
import '../widgets/quiz widgets/quiz_info_square.dart';

class WatchController extends GetxController {
  late final String categoryName;
  late final WatchModel model;
  late final TaskCategoryModel cat;
  final allWatchTasks = <WatchModel>[].obs;

  @override
  void onReady() {
    categoryName = Get.arguments as String;
    getAllWatchTasks();
    super.onReady();
  }

  Future<void> getAllWatchTasks() async {
    //List<String> imgName = ["Harry Potter", "Programming"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('User')
          .doc(currentUser.uid)
          .collection('Tasks')
          .doc(categoryName)
          .collection('Watch')
          .get();

      final watchList =
          data.docs.map((watch) => WatchModel.fromSnapshot(watch)).toList();
      allWatchTasks.assignAll(watchList);
    } catch (e) {
      print(e);
    }
  }

  // void navigateToQuestions({required WatchModel watch}) {
  //   //AuthController authController = Get.find();

  //   showPopupAlertDialog(watchModel: watch);
  //   //Get.toNamed(QuizQuestionScreen.routeName, arguments: quiz);
  // }

  void showPopupAlertDialog({required WatchModel watchModel}) {
    Get.dialog(
        showPopup(
            onTapStart: () {
              // Get.toNamed(VideoPlayer.routeName, arguments: watchModel);
            },
            onTapCancel: () {
              Get.back();
            },
            watchModel: watchModel),
        barrierDismissible: false);
  }

  Widget showPopup(
      {required VoidCallback onTapStart,
      required VoidCallback onTapCancel,
      required WatchModel watchModel}) {
    double buttonHeight = 35;
    double buttonWidth = 80;
    return AlertDialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(color: Color.fromARGB(221, 36, 36, 36))),
      backgroundColor: darkBackgroundColor,
      //shadowColor: fiservColor,
      elevation: 20,
      content: SizedBox(
        width: 400,
        height: 200,
        child: Column(
          //mainAxisSize: MainAxisSize.values,
          children: [
            const SizedBox(height: 10),
            Text(
              watchModel.videoTitle,
              style: GoogleFonts.quicksand(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: fiservColor),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: QuizInfoSquare(
                        icon: Icons.book_rounded,
                        text: '${watchModel.exp} exp')),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: QuizInfoSquare(icon: Icons.timer, text: 'time'),
                )
              ],
            ),
            const SizedBox(height: 15),
            Text(
              watchModel.popUpDescription,
              style: GoogleFonts.quicksand(color: darkTextColor),
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: fiservColor),
                      backgroundColor:
                          darkBackgroundColor, /*shadowColor: fiservColor*/
                    ),
                    onPressed: onTapCancel,
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          color: fiservColor,
                          fontSize: 14),
                    )),
              ),
              SizedBox(
                height: buttonHeight,
                width: buttonWidth,
                child: ElevatedButton(
                    style: TextButton.styleFrom(
                        side: const BorderSide(color: fiservColor),
                        backgroundColor: fiservColor),
                    onPressed: onTapStart,
                    child: Text("Start",
                        style: TextStyle(
                            color: darkTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15))),
              ),
            ],
          ),
        )
      ],
    );
  }
}
