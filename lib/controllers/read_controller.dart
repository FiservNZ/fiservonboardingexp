import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/model/read_model.dart';
import 'package:fiservonboardingexp/screens/task%20pages/read_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase references/firebase_refs.dart';
import '../util/constants.dart';
import '../widgets/quiz widgets/quiz_info_square.dart';

class ReadController extends GetxController {
  late final String categoryName;
  late ReadModel document;
  final allReadTasks =
      <ReadModel>[]; // Initializes a collection of read tasks as an array.
  RxInt selectedIndex = RxInt(0); // Initialize with a default index of 0.

  @override
  void onReady() {
    categoryName = Get.arguments as String;
    getAllReadTasks();
    super.onReady();
  }

  // Defines the setSelectedIndex method
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
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

      final readList = data.docs.map((document) {
        // Convert each document to a ReadModel
        return ReadModel(
          id: document.id,
          title: document['title'],
          description: document['description'],
          content: document['content'],
          time: document['time'],
          isDone: document['isDone'],
        );
      }).toList();

      // Assign the list of ReadModel objects to allReadTasks.
      allReadTasks.assignAll(readList);

      // After data is loaded, the selected index an be set.
      setSelectedIndex(0);
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void showPopupAlertDialog({required ReadModel readModel}) {
    setSelectedIndex(allReadTasks.indexOf(readModel));
    Get.dialog(
        showPopup(
            onTapStart: () {
              Get.toNamed(ReadPage.routeName);
            },
            onTapCancel: () {
              Get.back();
            },
            readModel: readModel),
        barrierDismissible: false);
  }

  Widget showPopup(
      {required VoidCallback onTapStart,
      required VoidCallback onTapCancel,
      required ReadModel readModel}) {
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

            // Displays the read task title
            Text(
              readModel.title,
              style: GoogleFonts.quicksand(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: fiservColor),
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
                        text: 'read model exp count for the specific task')),
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
              // Cancel button
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

              // Start button
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
