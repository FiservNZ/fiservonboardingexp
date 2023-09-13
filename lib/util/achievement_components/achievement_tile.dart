import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

// This class is used to create the
class Achievement extends StatefulWidget {
  final String title;
  final String iconName;
  final bool isCompleted;
  final String award;
  final int size;

  Achievement({
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
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 32, 67),
          borderRadius: BorderRadius.circular(6.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: fiservColor.withOpacity(0.5),
          //     spreadRadius: 3,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: Container(
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
              // Text(
              //   widget.title,
              //   style: const TextStyle(
              //     fontFamily: 'Roboto',
              //     fontSize: 16,
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 20.0),
                child: Image.asset(
                  widget.iconName,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.isCompleted ? "Completed" : "InCompleted",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
