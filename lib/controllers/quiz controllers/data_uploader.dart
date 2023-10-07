import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/model/quiz_model.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/loading_status.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../firebase references/firebase_refs.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  // uploads data from json files to the firestore database
  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;

    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // load json file and print path
    final quizzesInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/json/quizzes") && path.contains(".json"))
        .toList();

    final complianceQuizzes = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/json/quizzes/compliance") && path.contains(".json"))
        .toList();

    final orientationQuizzes = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/json/quizzes/orientation") && path.contains(".json"))
        .toList();

    final customsQuizzes = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/json/quizzes/customs_and_cultures") && path.contains(".json"))
        .toList();
    final healthSafetyQuizzes = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/json/quizzes/health") && path.contains(".json"))
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

    for (var quiz in complianceQuizzes) {
      String complianceContent = await rootBundle.loadString(quiz);
      quizzes.add(QuizModel.fromJSON(jsonDecode(complianceContent)));
      // Use the below to test if the project can pull the content from the quiz json files.
      // It will print it out in the console. To find it quickly, in the filter, search 'flutter'
      // print(complianceQuizzes);
    }

    for (var quiz in orientationQuizzes) {
      String orientationContent = await rootBundle.loadString(quiz);
      quizzes.add(QuizModel.fromJSON(jsonDecode(orientationContent)));
      // Use the below to test if the project can pull the content from the quiz json files.
      // It will print it out in the console. To find it quickly, in the filter, search 'flutter'
      // print(orientationQuizzes);
    }

    for (var quiz in customsQuizzes) {
      String customsCulturesContent = await rootBundle.loadString(quiz);
      quizzes.add(QuizModel.fromJSON(jsonDecode(customsCulturesContent)));
      // Use the below to test if the project can pull the content from the quiz json files.
      // It will print it out in the console. To find it quickly, in the filter, search 'flutter'
      // print(customsQuizzes);
    }

    for (var quiz in healthSafetyQuizzes) {
      String healthSafetyContent = await rootBundle.loadString(quiz);
      quizzes.add(QuizModel.fromJSON(jsonDecode(healthSafetyContent)));
      // Use the below to test if the project can pull the content from the quiz json files.
      // It will print it out in the console. To find it quickly, in the filter, search 'flutter'
      // print(healthSafetyQuizzes);
    }

    var batch = firestore.batch();

    // for (var quiz in quizzes) {
    //   batch.set(complianceQuiz.doc(quiz.id), {
    //     "title": quiz.title,
    //     "image_url": quiz.imageUrl,
    //     "description": quiz.description,
    //     "quiz_duration": quiz.quizDuration,
    //     "question_count": quiz.questions == null ? 0 : quiz.questions!.length,
    //     "exp": quiz.exp,
    //     "exp_gained": quiz.expGained
    //   });
    //   for (var questions in quiz.questions!) {
    //     final questionCollection =
    //         questionRef(quizId: quiz.id, questionId: questions.id);
    //     batch.set(questionCollection, {
    //       "question": questions.question,
    //       "correct_answer": questions.correctAnswer
    //     });

    //     for (var options in questions.options!) {
    //       batch.set(
    //           questionCollection.collection("options").doc(options.identifier),
    //           {"identifier": options.identifier, "answer": options.answer});
    //     }
    //   }
    // }

     for (var quiz in quizzes) {
      batch.set(complianceQuiz.doc(quiz.id), {
        "title": quiz.title,
        "image_url": quiz.imageUrl,
        "description": quiz.description,
        "quiz_duration": quiz.quizDuration,
        "question_count": quiz.questions == null ? 0 : quiz.questions!.length,
        "exp": quiz.exp,
        "exp_gained": quiz.expGained
      });
      for (var questions in quiz.questions!) {
        final complianceQuestions =
            complianceQRef(quizId: quiz.id, questionId: questions.id);
        batch.set(complianceQuestions, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var options in questions.options!) {
          batch.set(
              complianceQuestions.collection("options").doc(options.identifier),
              {"identifier": options.identifier, "answer": options.answer});
        }
      }
    }

     for (var quiz in quizzes) {
      batch.set(orientationQuiz.doc(quiz.id), {
        "title": quiz.title,
        "image_url": quiz.imageUrl,
        "description": quiz.description,
        "quiz_duration": quiz.quizDuration,
        "question_count": quiz.questions == null ? 0 : quiz.questions!.length,
        "exp": quiz.exp,
        "exp_gained": quiz.expGained
      });
      for (var questions in quiz.questions!) {
        final orientationQuestion =
            orientationQRef(quizId: quiz.id, questionId: questions.id);
        batch.set(orientationQuestion, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var options in questions.options!) {
          batch.set(
              orientationQuestion.collection("options").doc(options.identifier),
              {"identifier": options.identifier, "answer": options.answer});
        }
      }
    }

     for (var quiz in quizzes) {
      batch.set(healthSafetyQuiz.doc(quiz.id), {
        "title": quiz.title,
        "image_url": quiz.imageUrl,
        "description": quiz.description,
        "quiz_duration": quiz.quizDuration,
        "question_count": quiz.questions == null ? 0 : quiz.questions!.length,
        "exp": quiz.exp,
        "exp_gained": quiz.expGained
      });
      for (var questions in quiz.questions!) {
        final healthSafetyQuestions =
            healthSafetyQRef(quizId: quiz.id, questionId: questions.id);
        batch.set(healthSafetyQuestions, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var options in questions.options!) {
          batch.set(
              healthSafetyQuestions.collection("options").doc(options.identifier),
              {"identifier": options.identifier, "answer": options.answer});
        }
      }
    }

     for (var quiz in quizzes) {
      batch.set(customsCultureQuiz.doc(quiz.id), {
        "title": quiz.title,
        "image_url": quiz.imageUrl,
        "description": quiz.description,
        "quiz_duration": quiz.quizDuration,
        "question_count": quiz.questions == null ? 0 : quiz.questions!.length,
        "exp": quiz.exp,
        "exp_gained": quiz.expGained
      });
      for (var questions in quiz.questions!) {
        final customsQuestions =
            customsCultureQRef(quizId: quiz.id, questionId: questions.id);
        batch.set(customsQuestions, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var options in questions.options!) {
          batch.set(
              customsQuestions.collection("options").doc(options.identifier),
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
