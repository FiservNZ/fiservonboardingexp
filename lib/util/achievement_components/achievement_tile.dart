import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

// This class is used to create the
class Achievement extends StatefulWidget {
  final String title;
  final String iconName;
  final bool isCompleted;

  const Achievement({
    super.key,
    required this.title,
    required this.iconName,
    required this.isCompleted,
  });

  @override
  AchievenmentState createState() => AchievenmentState();
}

class AchievenmentState extends State<Achievement> {
  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          color: selectedTheme.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 15,
                color: selectedTheme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Image.asset(
                widget.iconName,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.isCompleted ? "Complete" : "Incomplete",
              style: TextStyle(
                fontSize: 15,
                color: selectedTheme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
