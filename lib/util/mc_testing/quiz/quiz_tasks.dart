import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/mc_testing/quiz/quiz_thumbnail.dart';
import 'package:flutter/material.dart';

import '../../../firebase references/firebase_refs.dart';

//This is the function we are going to use to obtain a list of WatchTasks depending on
//the category selected. This will also generate the thumbnail for our module screen.
class QuizTask {
  final String title;
  final String description;
  final int questionCount;

  QuizTask({
    required this.title,
    required this.description,
    required this.questionCount,
  });
}

Future<List<Widget>> getQuizTaskWidgets(String category) async {
  final List<Widget> quizTaskWidgets = [];

  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(category)
        .collection('Quiz')
        .where('isDone', isEqualTo: false)
        .get();

    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final task = QuizTask(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        questionCount: data['question_count'] ?? '0',
      );

      // Create a VideoThumbnail widget for each watch task
      final quizThumbnail = QuizThumbnail(
        quizTitle: task.title,
        quizDescription: task.description,
        taskCategory: category,
      );

      quizTaskWidgets.add(quizThumbnail);
    }
  } catch (e) {
    print('Error fetching watch tasks: $e');
  }

  return quizTaskWidgets;
}
