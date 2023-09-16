import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/model/read_model.dart';
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
        // Convert each document to a ReadModel.
        return ReadModel(
          id: document.id,
          title: document['title'],
          content: document['content'],
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
    Get.dialog(
        showPopup(
            onTapStart: () {
              // Get.toNamed(VideoPlayer.routeName, arguments: watchModel);
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
            Text(
              readModel.title,
              style: GoogleFonts.quicksand(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: fiservColor),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // add exp to the read model
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: QuizInfoSquare(
                        icon: Icons.book_rounded,
                        //'${readModel.exp} exp'
                        text: 'read model exp count for the specific task')),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  // add a time variable to read model of how long you think the specific task would take
                  child: QuizInfoSquare(icon: Icons.timer, text: 'time'),
                )
              ],
            ),
            const SizedBox(height: 15),
            Text(
              // add a property in read model for a short desc
              'read model pop up & card info here',
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
