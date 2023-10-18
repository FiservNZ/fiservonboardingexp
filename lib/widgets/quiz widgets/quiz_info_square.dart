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
      child: Flexible(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: selectedTheme.colorScheme.secondary),
              color: selectedTheme.colorScheme.onBackground),
          child: Flexible(
            flex: 1,
            child: SizedBox(
              width: 75,
              height: 65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: selectedTheme.colorScheme.secondary,
                    size: 27,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    text,
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: selectedTheme.colorScheme.primary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
