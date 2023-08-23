import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/screens/nav_app_overlay.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Handles the interaction between user and firebase database (inc updates, etc)
class ChecklistTile extends StatelessWidget {
  final Map<String, dynamic> task;
  Function(bool?)? onChanged;
  final FirebaseFirestore firestore;

  ChecklistTile({
    required this.task,
    required this.onChanged,
    required this.firestore,
  });

  @override
  Widget build(BuildContext context) {
    bool taskCompleted = task['taskCompleted'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: FiservColor,
              ),
              child: Checkbox(
                value: taskCompleted,
                onChanged: (value) {
                  firestore
                      .collection('General Checklist')
                      .doc('ET9OmM0iAtcszMPWHINV')
                      .update({task['taskName']: value});
                  onChanged?.call(value);
                },
                activeColor: FiservColor,
              ),
            ),
            Flexible(
              child: Text(
                task['taskName'],
                style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
