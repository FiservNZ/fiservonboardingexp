import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
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
          color: Color(0xFF1b1b1d),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: fiservColor,
              ),
              child: Checkbox(
                value: taskCompleted,
                onChanged: (value) {
                  String uid = fireAuth.currentUser!.uid;
                  firestore
                      .collection('User')
                      .doc(uid)
                      .collection('General Checklist')
                      .doc('list')
                      .update({task['taskName']: value});
                  onChanged?.call(value);
                },
                activeColor: fiservColor,
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
