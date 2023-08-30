import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

// UI implementation for the question and answer expansion tiles
class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: ExpansionTile(
        title: Text(
          question,
          // Text colour - Questions
          style:
              const TextStyle(color: fiservColor, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            // Text colour - Answers
            child: Text(
              answer,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
