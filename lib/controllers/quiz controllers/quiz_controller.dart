import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/quiz_info_square.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../firebase references/firebase_refs.dart';
import '../../model/quiz_model.dart';
import '../../model/task_category_model.dart';
import '../../screens/task pages/quiz screens/question_screen.dart';
import '../../firebase references/services/firebase_storage_service.dart';

class QuizController extends GetxController {
  late final String categoryName;
  late final QuizModel quiz;
  late final TaskCategoryModel cat;
  final allQuizImages = <String>[].obs;
  final allQuizzes = <QuizModel>[].obs;

  @override
  void onReady() {
    categoryName = Get.arguments as String;
    getAllQuizzes();
    super.onReady();
  }

  Future<void> getAllQuizzes() async {
    List<String> imgName = ["Harry Potter", "Programming"];
    try {
      //QuerySnapshot<Map<String, dynamic>> data = await quizref.get();

      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection('User')
          .doc(currentUser.uid)
          .collection('Tasks')
          .doc(categoryName)
          .collection('Quiz')
          .get();

      final quizList =
          data.docs.map((quiz) => QuizModel.fromSnapshot(quiz)).toList();
      allQuizzes.assignAll(quizList);

      for (var quiz in quizList) {
        if (imgName.contains(quiz.title)) {
          final imgUrl = await Get.find<FirebaseStorageService>()
              .getStorageRef(quiz.title);
          quiz.imageUrl = imgUrl;
          debugPrint(imgUrl);
        }
      }
      allQuizzes.assignAll(quizList);
    } catch (e) {
      debugPrint(e as String?);
    }
  }

  void navigateToQuestions({required QuizModel quiz, bool tryAgain = false}) {
    // AuthController authController = Get.find();
    if (tryAgain) {
      Get.back();
      Get.toNamed(QuestionScreen.routeName,
          arguments: quiz, preventDuplicates: false);
    } else {
      showPopupAlertDialog(quizModel: quiz);
      //Get.toNamed(QuizQuestionScreen.routeName, arguments: quiz);
    }
  }

  void showPopupAlertDialog({required QuizModel quizModel}) {
    Get.dialog(
        showPopup(
            onTapStart: () {
              Get.toNamed(QuestionScreen.routeName, arguments: quizModel);
              //Naviagte to Quiz Page
            },
            onTapCancel: () {
              Get.back();
            },
            quizModel: quizModel),
        barrierDismissible: false);
  }

  Widget showPopup(
      {required VoidCallback onTapStart,
      required VoidCallback onTapCancel,
      required QuizModel quizModel}) {
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
              quizModel.title,
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
                        icon: Icons.question_mark_rounded,
                        text: '${quizModel.questionCount} questions')),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: QuizInfoSquare(
                        icon: Icons.book_rounded,
                        text: '${quizModel.exp} exp')),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: QuizInfoSquare(
                      icon: Icons.timer, text: quizModel.timeConverter()),
                )
              ],
            ),
            const SizedBox(height: 15),
            Text(
              quizModel.description,
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
