import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../firebase references/firebase_refs.dart';

class VideoThumbnail extends StatelessWidget {
  final String videoUrl;
  final String videoTitle;
  final String taskCategory;

  const VideoThumbnail({
    super.key,
    required this.videoTitle,
    required this.taskCategory,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return GestureDetector(
      onTap: () {
        debugPrint('Video Tapped');
        FirebaseFirestore.instance
            .collection('User')
            .doc(currentUser.uid)
            .collection('Tasks')
            .doc(taskCategory)
            .collection('Watch')
            .where('videoUrl',
                isEqualTo: videoUrl) // Match based on the local variable
            .get()
            .then((querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            final snapshot = querySnapshot.docs[0].data();

            Get.to(VideoPlayer(
              videoSource: snapshot['videoUrl'],
              videoTitle: snapshot['videoTitle'],
              videoDescription: snapshot['videoDescription'],
            ));
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
                    'assets/icon/video_thumbnail_icon.png',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              children: [
                Text(
                  videoTitle,
                  style: TextStyle(
                    color: selectedTheme.colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ).merge(GoogleFonts.quicksand()),
                ),
                const SizedBox(height: 10),
                Text(
                  'Category: $taskCategory',
                  style: TextStyle(
                    color: selectedTheme.colorScheme.primary,
                    fontSize: 14,
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
