import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/elle_testing/models/quiz_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../firebase_ref/firebase_ref.dart';

class QuestionController extends GetxController {
  late QuizModel quizModel;
  final allQuizQuestions = <Question>[];

  @override
  void onReady() {
    final quizQuestion = Get.arguments as QuizModel;
    print(quizQuestion.id);
    loadData(quizQuestion);
    super.onReady();
  }

  Future<void> loadData(QuizModel quizQuestion) async {
    quizModel = quizQuestion;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await quizref.doc(quizQuestion.id).collection("questions").get();
/*
      final questions = questionQuery.docs
          .map((snapshot) => Question.fromSnapshot(snapshot))
          .toList();

      quizQuestion.questions = questions;

      for (Question question in quizQuestion.questions!) {
        final QuerySnapshot<Map<String, dynamic>> optionQuery = await quizref
            .doc(quizQuestion.id)
            .collection("questions")
            .doc(question.id)
            .collection("options")
            .get();

        final options = optionQuery.docs
            .map((option) => Option.fromSnapshot(option))
            .toList();

        question.options = options;

        if (quizQuestion.questions != null &&
            quizQuestion.questions!.isNotEmpty) {
          allQuizQuestions.assignAll(quizQuestion.questions!);
        }
      } */
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
