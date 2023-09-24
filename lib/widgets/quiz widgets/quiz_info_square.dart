import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/constants.dart';

class QuizInfoSquare extends StatelessWidget {
  final IconData icon;
  final String text;

  const QuizInfoSquare({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: selectedTheme.colorScheme.primary),
            color: selectedTheme.colorScheme.onBackground),
        child: SizedBox(
          width: 70,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selectedTheme.colorScheme.secondary),
              const SizedBox(height: 5),
              Text(
                text,
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: selectedTheme.colorScheme.secondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
