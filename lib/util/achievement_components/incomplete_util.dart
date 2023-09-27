import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';

// This class is used to create the
class IncompleteAchv extends StatefulWidget {
  final String title;
  final String iconName;
  final bool isCompleted;
  final String hour;

  IncompleteAchv({
    super.key,
    required this.hour,
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
    ThemeData selectedTheme = getSelectedTheme(context);
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: selectedTheme.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(10.0),
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
              constraints: const BoxConstraints(
                maxHeight: 160,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  widget.iconName,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 23,
                color: selectedTheme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: widget.hour.isNotEmpty,
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                  SizedBox(width: 30),
                  Text(
                    widget.hour,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " hours",
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedTheme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              widget.isCompleted ? "Complete" : "Incomplete",
              style: TextStyle(
                fontSize: 17,
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
