import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/auth_controller.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/mc_testing/module/module_screen.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/quiz_info_square.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../firebase references/firebase_refs.dart';
import '../../model/quiz_model.dart';
import '../../model/task_category_model.dart';
import '../../screens/task pages/quiz screens/question_screen.dart';
import 'package:flutter/material.dart';

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
    //List<String> imgName = ["Harry Potter", "Programming"];
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

      // for (var quiz in quizList) {
      //   if (imgName.contains(quiz.title)) {
      //     final imgUrl = await Get.find<FirebaseStorageService>()
      //         .getStorageRef(quiz.title);
      //     quiz.imageUrl = imgUrl;
      //     debugPrint(imgUrl);
      //   }
      // }
      allQuizzes.assignAll(quizList);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // void navigateToQuestions({required QuizModel quiz, bool tryAgain = false}) {
  //   // AuthController authController = Get.find();
  //   if (tryAgain) {
  //     Get.back();
  //     Get.toNamed(QuestionScreen.routeName,
  //         arguments: quiz, preventDuplicates: false);
  //   } else {
  //     showPopupAlertDialog(quizModel: quiz);
  //     //Get.toNamed(QuizQuestionScreen.routeName, arguments: quiz);
  //   }
  // }

  void navigateToQuestions({required QuizModel quiz}) {
    AuthController authController = Get.find();

    showPopupAlertDialog(
        quizModel: quiz, categoryName: categoryName, theme: selectedTheme);
    //Get.toNamed(QuizQuestionScreen.routeName, arguments: quiz);
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
    backgroundColor: selectedTheme.colorScheme.background,
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
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: selectedTheme.colorScheme.secondary),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: QuizInfoSquare(
                      icon: Icons.question_mark_rounded,
                      text: quizModel.questionCount == 1
                          ? '${quizModel.questionCount} Question'
                          : '${quizModel.questionCount} Questions')),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: QuizInfoSquare(
                      icon: Icons.book_rounded, text: '${quizModel.exp} exp')),
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
            SizedBox(
              height: buttonHeight,
              width: buttonWidth,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: selectedTheme.colorScheme.primary),
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
            SizedBox(
              height: buttonHeight,
              width: buttonWidth,
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                      side:
                          BorderSide(color: selectedTheme.colorScheme.primary),
                      backgroundColor: selectedTheme.colorScheme.onBackground),
                  onPressed: onTapStart,
                  child: Text("Start",
                      style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15))),
            ),
          ],
        ),
      )
    ],
  );
}
