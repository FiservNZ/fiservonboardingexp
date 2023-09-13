import 'package:fiservonboardingexp/controllers/quiz%20controllers/question_controller.dart';

import '../../util/elle_testing/firebase_ref/firebase_ref.dart';

extension QuestioncontrollerExtension on QuestionController {
  int get correctQuestionCount => allQuizQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return 'You got $correctQuestionCount out of ${allQuizQuestions.length} correct';
  }

  Future<void> saveQuizResults() async {
    var batch = firestore.batch();
    String taskType = 'Quiz';
    String user = 'userID';
    //User? user = Get.find<AuthController>().//need to get the user
    batch.set(
        taskRef(userId: user, taskType: taskType)
            .collection('Quiz Results')
            .doc(quizModel.id),
        {
          "correct_answer": '$correctQuestionCount/$allQuizQuestions.length',
          "quiz_id": quizModel.id,
          //'time': quizModel.quizDuration - remainSeconds
        });
    batch.commit();
    navigateToHome();
  }
}
