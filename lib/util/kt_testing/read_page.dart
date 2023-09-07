import 'package:fiservonboardingexp/util/kt_testing/read_controller.dart';
import 'package:fiservonboardingexp/util/kt_testing/read_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'package:fiservonboardingexp/widgets/progress_bar.dart';

class ReadPage extends GetView<ReadController> {
  final ProgressBar _progressBar = const ProgressBar();
  final ReadModel model;
  const ReadPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(
            model.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: fiservColor,
              fontWeight: FontWeight.bold,
              fontSize: 42,
            ),
          ),
        ),

        // Image (from local assets folder not firebase). Needs to be chagned as its hard coded.
        const Padding(
          padding: EdgeInsets.all(40.0),
          child: Image(image: AssetImage('assets/images/platypus.webp')),
        ),

        // Content
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Text(
            model.content,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),

        // Close button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text(
              'Back',
              style: TextStyle(
                color: Color(0xFFFF6600),
              ),
            ),
          ),
        ),

        // Task finished button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120),
          child: ElevatedButton(
            onPressed: () {
              int points = 1;
              _progressBar.addPoints(points);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: fiservColor,
                fixedSize: Size(120, 35)),
            child: const Text('Task Finished'),
          ),
        ),
      ],
    ));
  }
}
