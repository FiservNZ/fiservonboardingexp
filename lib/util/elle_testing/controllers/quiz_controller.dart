import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/elle_testing/controllers/auth_controller.dart';
import 'package:fiservonboardingexp/util/elle_testing/screens/quiz_question_screen.dart';
import 'package:get/get.dart';

import '../firebase_ref/firebase_ref.dart';
import '../models/quiz_model.dart';
import '../screens/question_screen.dart';
import '../services/firebase_storage_service.dart';
import '../widgets/popup_widget.dart';

class QuizController extends GetxController {
  late final QuizModel quiz;
  final allQuizImages = <String>[].obs;
  final allQuizzes = <QuizModel>[].obs;

  @override
  void onReady() {
    getAllQuizzes();
    super.onReady();
  }

  Future<void> getAllQuizzes() async {
    List<String> imgName = ["Harry Potter", "Programming"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await quizref.get();
      final quizList =
          data.docs.map((quiz) => QuizModel.fromSnapshot(quiz)).toList();
      allQuizzes.assignAll(quizList);

      for (var quiz in quizList) {
        if (imgName.contains(quiz.title)) {
          final imgUrl = await Get.find<FirebaseStorageService>()
              .getStorageRef(quiz.title);
          quiz.imageUrl = imgUrl;
          print(imgUrl);
        }
      }
      allQuizzes.assignAll(quizList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestions({required QuizModel quiz, bool tryAgain = false}) {
    AuthController authController = Get.find();
    if (tryAgain) {
      Get.back();
    } else {
      showPopupAlertDialog();
      //Get.toNamed(QuizQuestionScreen.routeName, arguments: quiz);
    }
  }

  void showPopupAlertDialog() {
    Get.dialog(
        Popups().showPopup(onTap: () {
          Get.toNamed(QuestionScreen.routeName, arguments: quiz);
          //Naviagte to Quiz Page
        }),
        barrierDismissible: false);
  }
}
