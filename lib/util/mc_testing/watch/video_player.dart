import 'package:fiservonboardingexp/model/watch_model.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/mc_testing/module/module_screen.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/video_player_widget.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/tasks_container.dart';
import 'package:fiservonboardingexp/util/progress_points.dart';
import 'package:fiservonboardingexp/widgets/exp_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../firebase references/firebase_refs.dart';

//This is the widget that will hold the VideoPlayerWidget + Other widgets
//Such as title, back and next button, mute button, and video description.
class VideoPlayer extends StatefulWidget {
  final String videoSource;
  final String videoTitle;
  final String videoDescription;

  const VideoPlayer({
    super.key,
    required this.videoSource,
    required this.videoTitle,
    required this.videoDescription,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final asset = 'assets/video/video.mp4';
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoSource == 'asset') {
      controller = VideoPlayerController.asset(asset)
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) => controller.play());
    } else {
      controller = VideoPlayerController.network(widget.videoSource)
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) => controller.play());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    final isMuted = controller.value.volume == 0;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Material(
        color: selectedTheme.colorScheme.background,
        child: Column(
          children: [
            //This is the main video screen that plays the video.
            VideoPlayerWidget(controller: controller),

            // Video Title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.videoTitle,
                style: TextStyle(
                  color: selectedTheme.colorScheme.secondary,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ).merge(
                    GoogleFonts.quicksand()), // Merge styles with GoogleFonts
              ),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      selectedTheme.colorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    dispose();
                    super.dispose();
                  },
                  child: const Text('Back'),
                ),
                CircleAvatar(
                  backgroundColor: selectedTheme.colorScheme.onBackground,
                  child: IconButton(
                    icon: Icon(
                      isMuted ? Icons.volume_mute : Icons.volume_up,
                      color: selectedTheme.colorScheme.primary,
                    ),
                    onPressed: () => controller.setVolume(isMuted ? 1 : 0),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      selectedTheme.colorScheme.secondary,
                    ),
                  ),
                  onPressed: () async {
                    bool confirm = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              selectedTheme.colorScheme.onBackground,
                          title: Text(
                            'Confirmation',
                            style: TextStyle(
                              color: selectedTheme.colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ).merge(GoogleFonts.quicksand()),
                          ),
                          content: Text(
                            "If you want to mark the task as done, click 'Yes.' To continue watching the video, click 'No.'",
                            style: TextStyle(
                              color: selectedTheme.colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ).merge(GoogleFonts.quicksand()),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                // User clicked No, close the dialog and don't add EXP
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: selectedTheme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ).merge(GoogleFonts.quicksand()),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // User clicked Yes, add EXP
                                Navigator.of(context).pop(true);
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: selectedTheme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ).merge(GoogleFonts.quicksand()),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirm == true) {
                      ExpBar expBar = const ExpBar(barwidth: 1);

                      // int currentEXP = await userColRef
                      //     .doc(currentUser.uid)
                      //     .get()
                      //     .then((doc) {
                      //   if (doc.exists) {
                      //     return doc.data()!['EXP'] ?? 0;
                      //   } else {
                      //     return 0;
                      //   }
                      // });
                      // await userColRef
                      //     .doc(currentUser.uid)
                      //     .update({'EXP': currentEXP + 25});

                      final querySnapshot = await userColRef
                          .doc(currentUser.uid)
                          .collection('Tasks')
                          .doc(currentCategory)
                          .collection('Watch')
                          .where('videoUrl', isEqualTo: widget.videoSource)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        final doc = querySnapshot.docs[0];

                        // Checks if task has been completed if not add a point to the progress bar
                        final isDone = doc['isDone'];
                        if (!isDone) {
                          addPointsToProgress(currentCategory);
                          expBar.addExperience(25);
                        }

                        await doc.reference.update({'isDone': true});
                      } else {
                        debugPrint('No Matching Document Found!');
                      }
                      Get.back();
                      Get.back();
                      Get.to(TasksContainer(watchCategory: currentCategory));
                    }
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
            // Video Description Container
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: selectedTheme.colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 4,
                    )
                  ]),
              child: Text(
                widget.videoDescription,
                style: TextStyle(
                  color: selectedTheme.colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ).merge(
                    GoogleFonts.quicksand()), // Merge styles with GoogleFonts
              ),
            ),
          ],
        ),
      ),
    );
  }
}
