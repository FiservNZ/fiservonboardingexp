import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/progress_bar_testing/progress_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/progress_bar_testing/progress_model.dart';

class ProgressBar extends StatelessWidget {
  final ProgressModel task;

  ProgressBar({required this.task});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    // Calculate progress percentage
    final double progressPercentage = task.currProgress / task.maxProgress;

    return Column(
      children: [
        // Display the progress bar
        LinearProgressIndicator(
          value: progressPercentage,
          color: Colors.blue, // Customize the color as needed
          backgroundColor:
              Colors.grey, // Customize the background color as needed
        ),

        // Display the progress text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress Bar',
              style: TextStyle(
                color: selectedTheme.colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ).merge(GoogleFonts.quicksand()),
            ),
            Text(
              '${task.currProgress} / ${task.maxProgress}',
              style: TextStyle(
                color: selectedTheme.colorScheme.primary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
