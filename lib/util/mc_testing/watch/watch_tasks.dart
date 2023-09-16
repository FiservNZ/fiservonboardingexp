import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/mc_testing/watch/video_thumbnail.dart';
import 'package:flutter/material.dart';

import '../../../firebase references/firebase_refs.dart';

//This is the function we are going to use to obtain a list of WatchTasks depending on
//the category selected. This will also generate the thumbnail for our module screen.
class WatchTask {
  final int index;
  final String title;
  final String description;
  final String videoSource;

  WatchTask({
    required this.index,
    required this.title,
    required this.description,
    required this.videoSource,
  });
}

Future<List<Widget>> getWatchTaskWidgets(String category) async {
  final List<Widget> watchTaskWidgets = [];

  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(category)
        .collection('Watch')
        .where('isDone', isEqualTo: false)
        .get();

    for (final doc in querySnapshot.docs) {
      int index = 0;
      final data = doc.data();
      final task = WatchTask(
        index: index,
        title: data['videoTitle'] ?? '',
        description: data['videoDescription'] ?? '',
        videoSource: data['videoUrl'] ?? '',
      );
      index++;

      // Create a VideoThumbnail widget for each watch task
      final videoThumbnail = VideoThumbnail(
        videoUrl: task.videoSource,
        videoTitle: task.title,
        taskCategory: category,
      );

      watchTaskWidgets.add(videoThumbnail);
    }
  } catch (e) {
    print('Error fetching watch tasks: $e');
  }

  return watchTaskWidgets;
}
