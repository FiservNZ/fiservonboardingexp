import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../firebase references/firebase_refs.dart';

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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return GestureDetector(
      onTap: () {
        debugPrint('Quiz Tapped!\nTitle: $quizTitle');
        FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .collection('Tasks')
            .doc(taskCategory)
            .collection('Quiz')
            .where('title', isEqualTo: quizTitle)
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final snapshot = querySnapshot.docs[0].data();
            //Implement later as I do not know where the task page is for quiz.
            // Get.to(VideoPlayer(
            //   videoSource: snapshot['videoUrl'],
            //   videoTitle: snapshot['videoTitle'],
            //   videoDescription: snapshot['videoDescription'],
            // ));
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
              children: [
                Text(
                  quizTitle,
                  style: TextStyle(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ).merge(GoogleFonts.quicksand()),
                ),
                const SizedBox(height: 10),
                Text(
                  'Description: $quizDescription',
                  style: TextStyle(
                    color: selectedTheme.colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ).merge(GoogleFonts.quicksand()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
