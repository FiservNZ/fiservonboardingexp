import 'package:flutter/material.dart';

class Achievement extends StatefulWidget {
  final String title;
  final String description;
  final String iconName;
  final bool isCompleted;

  Achievement({
    super.key,
    required this.title,
    required this.description,
    required this.iconName,
    required this.isCompleted,
  });

  @override
  _AchievenmentState createState() => _AchievenmentState();
}

class _AchievenmentState extends State<Achievement> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 32, 67),
          borderRadius: BorderRadius.circular(6.0),
          /*boxShadow: [
              BoxShadow(
                color: fiservColor.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],*/
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Image.asset(
                widget.iconName,
              ),
            ),
            Text(
              widget.isCompleted ? "Completed" : "InCompleted",
              style: const TextStyle(
                fontSize: 16,
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
