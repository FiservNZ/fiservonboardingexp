import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/mc_testing/read/read_thumbnail.dart';
import 'package:flutter/material.dart';

import '../../../firebase references/firebase_refs.dart';

//This is the function we are going to use to obtain a list of WatchTasks depending on
//the category selected. This will also generate the thumbnail for our module screen.
class ReadTask {
  final String title;
  final String description;
  final String time;

  ReadTask({
    required this.title,
    required this.description,
    required this.time,
  });
}

Future<List<Widget>> getReadTaskWidgets(String category) async {
  final List<Widget> readTaskWidgets = [];

  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(category)
        .collection('Read')
        .where('isDone', isEqualTo: false)
        .get();

    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final task = ReadTask(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        time: data['time'] ?? '',
      );

      // Create a VideoThumbnail widget for each watch task
      final readThumbnail = ReadThumbnail(
        readTitle: task.title,
        readDescription: task.description,
        taskCategory: category,
      );

      readTaskWidgets.add(readThumbnail);
    }
  } catch (e) {
    print('Error fetching watch tasks: $e');
  }

  return readTaskWidgets;
}
