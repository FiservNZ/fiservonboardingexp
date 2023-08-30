import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/elle_testing/models/quiz_model.dart';
import 'package:fiservonboardingexp/util/elle_testing/firebase_ref/loading_status.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../firebase_ref/firebase_ref.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;

    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // load json file and print path
    final quizzesInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/json/quizzes") && path.contains(".json"))
        .toList();
    // to test what json files it can find:
    // print(quizzesInAssets);

    List<QuizModel> quizzes = [];

    for (var quiz in quizzesInAssets) {
      String stringQuizContent = await rootBundle.loadString(quiz);
      quizzes.add(QuizModel.fromJSON(jsonDecode(stringQuizContent)));

      // Use the below to test if the project can pull the content from the quiz json files.
      // It will print it out in the console. To find it quickly, in the filter, search 'flutter'
      // print(stringQuizContent);
    }
    var batch = fireStore.batch();

    for (var quiz in quizzes) {
      batch.set(quizref.doc(quiz.id), {
        "title": quiz.title,
        "image_url": quiz.imageUrl,
        "description": quiz.description,
        "quiz_duration": quiz.quizDuration,
        "question_count": quiz.questions == null ? 0 : quiz.questions!.length
      });
      for (var questions in quiz.questions!) {
        final questionCollection =
            questionRef(quizId: quiz.id, questionId: questions.id);
        batch.set(questionCollection, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var options in questions.options!) {
          batch.set(
              questionCollection.collection("options").doc(options.identifier),
              {"identifier": options.identifier, "answer": options.answer});
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
    // Use to print the id of a quiz in the list
    // print("Quiz id: ${quizzes[0].id}");

    // Use to find the length of the list
    // print("There are ${quizzes.length} files in the list");
  }
}
