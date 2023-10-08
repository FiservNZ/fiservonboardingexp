import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../firebase references/firebase_refs.dart';
import '../../screens/module/task pages/watch screens/video_player.dart';

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

  Future<Map<String, dynamic>> fetchData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(taskCategory)
        .collection('Watch')
        .where('videoUrl', isEqualTo: videoUrl)
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
              debugPrint('Video Tapped');

              Get.to(VideoPlayer(
                videoSource: data['videoUrl'],
                videoDescription: data['videoDescription'],
                videoTitle: data['videoTitle'],
              ));
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
