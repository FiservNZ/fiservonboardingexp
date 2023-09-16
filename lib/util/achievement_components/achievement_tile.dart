import 'package:flutter/material.dart';

// This class is used to create the
class Achievement extends StatefulWidget {
  final String title;
  final String iconName;
  final bool isCompleted;
  final String award;
  final int size;

  const Achievement({
    super.key,
    required this.award,
    required this.title,
    required this.iconName,
    required this.isCompleted,
    required this.size,
  });

  @override
  AchievenmentState createState() => AchievenmentState();
}

class AchievenmentState extends State<Achievement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 32, 67),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
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
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
