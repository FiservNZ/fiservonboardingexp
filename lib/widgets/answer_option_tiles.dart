import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/elle_testing/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

class AnswerOptionTiles extends StatelessWidget {
  final String answerOption;
  final bool isSelected;
  final VoidCallback onTap;
  const AnswerOptionTiles(
      {super.key,
      required this.answerOption,
      this.isSelected = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: isSelected ? Colors.black87 : Theme.of(context).cardColor,
            border: Border.all(
                color:
                    isSelected ? Colors.black : Theme.of(context).cardColor)),
        child: Text(
          answerOption,
          style: TextStyle(
            color: isSelected ? fiservColor : null,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
