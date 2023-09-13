import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/elle_testing/themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: isSelected ? Colors.black87 : darkTileColor,
            border:
                Border.all(color: isSelected ? fiservColor : darkTileColor)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                answerIdentifier,
                style: GoogleFonts.quicksand(
                  color: isSelected ? fiservColor : darkTextColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                answerOption,
                style: GoogleFonts.quicksand(
                  color: isSelected ? fiservColor : darkTextColor,
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
