import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

// This class is used to create the
class IncompleteAchv extends StatefulWidget {
  final String title;
  final String iconName;
  final bool isCompleted;
  final String award;

  IncompleteAchv({
    super.key,
    required this.award,
    required this.title,
    required this.iconName,
    required this.isCompleted,
  });

  @override
  IncompleteAchvState createState() => IncompleteAchvState();
}

class IncompleteAchvState extends State<IncompleteAchv> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 30, 32, 67),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: [
            // Expanded(
            //   child: Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            //     child: Image.asset(
            //       widget.iconName,
            //       width: double.infinity,
            //       height: 100,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 150, // 固定高度
              ),
              child: Image.asset(
                widget.iconName,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // 让文本居中对齐
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                SizedBox(width: 30),
                Icon(
                  Icons.lock_clock,
                  color: Colors.white,
                ),
                // Text(
                //   "",
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              widget.isCompleted ? "Completed" : "InCompleted",
              style: const TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
