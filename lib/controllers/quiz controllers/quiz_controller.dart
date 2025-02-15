import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/quiz_info_square.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../firebase references/firebase_refs.dart';
import '../../model/quiz_model.dart';
import '../../model/task_category_model.dart';
import '../../screens/module/task pages/quiz screens/question_screen.dart';

class QuizController extends GetxController {
  late final String categoryName;
  late final QuizModel quiz;
  late final TaskCategoryModel cat;
  final allQuizImages = <String>[].obs;
  final allQuizzes = <QuizModel>[].obs;

  ThemeData get selectedTheme => Get.theme;

  @override
  void onReady() {
    categoryName = Get.arguments as String;
    getAllQuizzes();
    super.onReady();
  }

  Future<void> getAllQuizzes() async {
    try {
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
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void navigateToQuestions({required QuizModel quiz}) {
    showPopupAlertDialog(
        quizModel: quiz, categoryName: categoryName, theme: selectedTheme);
  }
}

void showPopupAlertDialog({
  required QuizModel quizModel,
  required String categoryName,
  required ThemeData theme,
}) {
  Get.dialog(
      showPopup(
          onTapStart: () {
            debugPrint('Current Category: $categoryName');
            Get.toNamed(QuestionScreen.routeName, arguments: quizModel);
            //Naviagte to Quiz Page
          },
          onTapCancel: () {
            Get.back();
          },
          quizModel: quizModel,
          selectedTheme: theme),
      barrierDismissible: false);
}

Widget showPopup({
  required VoidCallback onTapStart,
  required VoidCallback onTapCancel,
  required QuizModel quizModel,
  required ThemeData selectedTheme,
}) {
  double buttonHeight = 35;
  double buttonWidth = 80;
  return AlertDialog(
    alignment: Alignment.center,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(color: Color.fromARGB(221, 36, 36, 36))),
    backgroundColor: selectedTheme.colorScheme.onBackground,
    elevation: 20,
    content: SizedBox(
      width: 400,
      height: 200,
      child: Column(
        children: [
          Text(
            quizModel.title,
            style: GoogleFonts.quicksand(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: selectedTheme.colorScheme.primary),
          ),
          const SizedBox(height: 15),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuizInfoSquare(
                    icon: Icons.question_mark_rounded,
                    text: quizModel.questionCount == 1
                        ? '${quizModel.questionCount} Question'
                        : '${quizModel.questionCount} Questions'),
                QuizInfoSquare(
                    icon: Icons.book_rounded, text: '${quizModel.exp} exp'),
                QuizInfoSquare(
                    icon: Icons.timer, text: quizModel.timeConverterTxt()),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Flexible(
            flex: 1,
            child: Text(
              quizModel.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                color: selectedTheme.colorScheme.primary,
                fontSize: 14, // Set your desired font size here
                fontWeight:
                    FontWeight.w600, // Set your desired font weight here
              ),
              overflow: TextOverflow.visible,
              maxLines: 2,
            ),
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
                    side:
                        BorderSide(color: selectedTheme.colorScheme.secondary),
                    backgroundColor: selectedTheme.colorScheme.onBackground,
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
