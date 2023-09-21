import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/screens/task%20pages/read_page.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../firebase references/firebase_refs.dart';

class ReadThumbnail extends StatelessWidget {
  final String readTitle;
  final String readDescription;
  final String taskCategory;

  const ReadThumbnail({
    super.key,
    required this.readTitle,
    required this.taskCategory,
    required this.readDescription,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return GestureDetector(
      onTap: () {
        debugPrint('Read Tapped!\nTitle: $readTitle');
        FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .collection('Tasks')
            .doc(taskCategory)
            .collection('Read')
            .where('title', isEqualTo: readTitle)
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final snapshot = querySnapshot.docs[0].data();
            //Implement later as I do not know where the task page is for read.
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
                    'assets/icon/read_thumbnail_icon.png',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              children: [
                Text(
                  readTitle,
                  style: TextStyle(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ).merge(GoogleFonts.quicksand()),
                ),
                const SizedBox(height: 10),
                Text(
                  'Description: $readDescription',
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
