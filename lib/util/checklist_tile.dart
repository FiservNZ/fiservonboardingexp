import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase references/firebase_refs.dart';
import 'package:provider/provider.dart';

// yellow squig Class Name
class ChecklistTile extends StatelessWidget {
  final Map<String, dynamic> task;
  Function(bool?)? onChanged;
  final FirebaseFirestore firestore;

  ChecklistTile({
    super.key,
    required this.task,
    required this.onChanged,
    required this.firestore,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;
    bool taskCompleted = task['taskCompleted'];

    // UI of the Checklist Tiles
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selectedTheme.colorScheme.background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Theme(
              data: ThemeData(
                unselectedWidgetColor: selectedTheme.colorScheme.secondary,
              ),
              child: Checkbox(
                value: taskCompleted,
                onChanged: (value) {
                  String uid = fireAuth.currentUser!.uid;
                  firestore
                      .collection('User')
                      .doc(uid)
                      .collection('Checklist')
                      .doc('List')
                      .update({task['taskName']: value}).then((_) {
                    onChanged?.call(value);
                  }).catchError((error) {});
                },
                activeColor: selectedTheme
                    .colorScheme.secondary, // Checkbox checked colour HERE
              ),
            ),
            Flexible(
              child: Text(
                task[
                    'taskName'], // Task name display and stuff below it is the text style (font, colour, size, etc)
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: selectedTheme.colorScheme.primary,
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
