import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AnswerOptionTiles extends StatelessWidget {
  final String answerIdentifier;
  final String answerOption;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerOptionTiles(
      {super.key,
      required this.answerOption,
      this.isSelected = false,
      required this.onTap,
      required this.answerIdentifier});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: isSelected
                ? selectedTheme.colorScheme.tertiary
                : selectedTheme.colorScheme.onBackground,
            border: Border.all(
                color: isSelected
                    ? selectedTheme.colorScheme.secondary
                    : selectedTheme.colorScheme.onBackground)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                answerIdentifier,
                style: GoogleFonts.quicksand(
                  color: isSelected
                      ? selectedTheme.colorScheme.primary
                      : selectedTheme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                answerOption,
                style: GoogleFonts.quicksand(
                  color: isSelected
                      ? selectedTheme.colorScheme.primary
                      : selectedTheme.colorScheme.secondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
