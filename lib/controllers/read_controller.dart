import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/model/read_model.dart';
import 'package:fiservonboardingexp/screens/module/task%20pages/read_page.dart';
import 'package:fiservonboardingexp/screens/module/module_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase references/firebase_refs.dart';
import '../util/constants.dart';
import '../widgets/quiz widgets/quiz_info_square.dart';

class ReadController extends GetxController {
  late final String categoryName;
  late ReadModel? model;
  final allReadTasks =
      <ReadModel>[]; // Initializes a collection of read tasks as an array.
  ThemeData get selectedTheme => Get.theme;

  @override
  void onReady() {
    categoryName = currentCategory;
    getAllReadTasks();
    super.onReady();
  }

  Future<void> getAllReadTasks() async {
    try {
      // Fetch the read documents from the read collection as a map.
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('User')
          .doc(currentUser.uid)
          .collection('Tasks')
          .doc(categoryName)
          .collection('Read')
          .get();

      //print("Number of documents fetched: ${data.docs.length}");

      final readList = data.docs.map((model) {
        // Convert each document to a ReadModel
        return ReadModel(
            id: model.id,
            title: model['title'],
            description: model['description'],
            content: model['content'],
            time: model['time'],
            isDone: model['isDone'],
            imageUrl: model['image_url']);
      }).toList();
      if (readList.isNotEmpty) {
        model = readList[0];
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void navigateToReadPage({required ReadModel readModel}) {
    if (model != null) {
      debugPrint('Model Initialised!');
      model = readModel;
      showPopupAlertDialog(
          readModel: readModel,
          categoryName: categoryName,
          theme: selectedTheme);
    } else {
      debugPrint('Model not initialised!');
    }
  }
}

void showPopupAlertDialog({
  required ReadModel readModel,
  required String categoryName,
  required ThemeData theme,
}) {
  Get.dialog(
      showPopup(
          onTapStart: () {
            debugPrint(readModel.description);
            Get.toNamed(ReadPage.routeName, arguments: readModel);
          },
          onTapCancel: () {
            Get.back();
          },
          readModel: readModel,
          selectedTheme: theme),
      barrierDismissible: false);
}

Widget showPopup(
    {required VoidCallback onTapStart,
    required VoidCallback onTapCancel,
    required ReadModel readModel,
    required ThemeData selectedTheme}) {
  double buttonHeight = 35;
  double buttonWidth = 80;
  return AlertDialog(
    alignment: Alignment.center,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: Color.fromARGB(221, 36, 36, 36))),
    backgroundColor: selectedTheme.colorScheme.onBackground,
    //shadowColor: fiservColor,
    elevation: 20,
    content: SizedBox(
      width: 400,
      height: 200,
      child: Column(
        //mainAxisSize: MainAxisSize.values,
        children: [
          const SizedBox(height: 10),

          // Displays the read task title
          Text(
            readModel.title,
            style: GoogleFonts.quicksand(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: selectedTheme.colorScheme.primary),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // add exp to the read model
              const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: QuizInfoSquare(
                      icon: Icons.book_rounded,
                      //'${readModel.exp} exp'
                      text: 'exp count')),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  // Time for how long the specific task would take
                  child: QuizInfoSquare(
                    icon: Icons.timer,
                    text: readModel.time.toString(),
                  ))
            ],
          ),
          const SizedBox(height: 15),

          // Short description about the read task
          Text(
            readModel.description,
            style:
                GoogleFonts.quicksand(color: selectedTheme.colorScheme.primary),
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
            // Cancel button
            SizedBox(
              height: buttonHeight,
              width: buttonWidth,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side:
                        BorderSide(color: selectedTheme.colorScheme.secondary),
                    backgroundColor: selectedTheme
                        .colorScheme.onBackground, /*shadowColor: fiservColor*/
                  ),
                  onPressed: onTapCancel,
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        color: selectedTheme.colorScheme.primary,
                        fontSize: 14),
                  )),
            ),

            // Start button
            SizedBox(
              height: buttonHeight,
              width: buttonWidth,
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                      side: BorderSide(
                          color: selectedTheme.colorScheme.secondary),
                      backgroundColor: selectedTheme.colorScheme.secondary),
                  onPressed: onTapStart,
                  child: Text("Start",
                      style: TextStyle(
                          color: selectedTheme.colorScheme.background,
                          fontWeight: FontWeight.bold,
                          fontSize: 15))),
            ),
          ],
        ),
      )
    ],
  );
}
