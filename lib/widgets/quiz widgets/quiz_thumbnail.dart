import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/quiz_controller.dart';
import 'package:fiservonboardingexp/model/quiz_model.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/screens/module/module_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../firebase references/firebase_refs.dart';

class QuizThumbnail extends StatelessWidget {
  final String quizTitle;
  final String quizDescription;
  final String taskCategory;

  const QuizThumbnail({
    super.key,
    required this.quizTitle,
    required this.taskCategory,
    required this.quizDescription,
  });

  Future<Map<String, dynamic>> fetchData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(taskCategory)
        .collection('Quiz')
        .where('title',
            isEqualTo: quizTitle) // Add this filter to fetch the specific quiz
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final snapshot = querySnapshot.docs[0].data();
      return snapshot;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No Data Available!');
          }

          final data = snapshot.data as Map<String, dynamic>;
          final bool isDone = data['isDone'] ?? false;
          return GestureDetector(
            onTap: () {
              debugPrint('Quiz Tapped!\nTitle: $quizTitle');
              FirebaseFirestore.instance
                  .collection('User')
                  .doc(currentUser.uid)
                  .collection('Tasks')
                  .doc(taskCategory)
                  .collection('Quiz')
                  .where('title',
                      isEqualTo:
                          quizTitle) // Add this filter to fetch the specific quiz
                  .get()
                  .then((querySnapshot) {
                if (querySnapshot.docs.isNotEmpty) {
                  QueryDocumentSnapshot doc = querySnapshot.docs.first;
                  String documentId = doc.id;
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;

                  // Create a QuizModel instance using the retrieved data
                  QuizModel quizModel = QuizModel(
                    id: documentId,
                    title: data['title'],
                    description: data['description'],
                    quizDuration: data['quiz_duration'],
                    questionCount: data['question_count'],
                    exp: data['exp'],
                    expGained: data['expGained'],
                    isDone: data['isDone'],
                  );
                  debugPrint("Document ID: $documentId");
                  showPopupAlertDialog(
                      quizModel: quizModel,
                      categoryName: currentCategory,
                      theme: selectedTheme);
                }
              }).catchError((error) {
                debugPrint('ERROR: $error');
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selectedTheme.colorScheme.onBackground,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/icon/quiz_thumbnail_icon.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quizTitle,
                        style: TextStyle(
                          color: selectedTheme.colorScheme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ),
                      const SizedBox(height: 5),
                      //Wraped in SizedBox to set a preferred width to clip text overflow
                      SizedBox(
                        width: 250,
                        child: Text(
                          "Description: $quizDescription",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: selectedTheme.colorScheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ).merge(GoogleFonts.quicksand()),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  isDone == true
                      ? Icon(
                          Icons.check,
                          color: selectedTheme.colorScheme.primary,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        });
  }
}
