import 'package:fiservonboardingexp/model/task_category_model.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatelessWidget {
  final TaskCategoryModel category;

  const ProgressBar({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    // Calculate progress percentage
    final double progressPercentage = category.curPoints / category.maxPoints;

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
              '${category.curPoints} / ${category.maxPoints}',
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
