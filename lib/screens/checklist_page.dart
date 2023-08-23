import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/widgets/app_bar_overlay.dart';
import 'package:fiservonboardingexp/screens/nav_app_overlay.dart';
import 'package:fiservonboardingexp/util/checklist_tile.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import '../main.dart';

// Handles the UI for the checklist
class ChecklistPage extends StatefulWidget {
  final FirebaseFirestore firestore;
  const ChecklistPage({Key? key, required this.firestore}) : super(key: key);

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  // ALL the tasks in the General Checklist collection from firebase.
  List<Map<String, dynamic>> tasks = [
    {
      'taskName': 'Book onboarding checkpoint with Manager for Day 5',
      'taskCompleted': false
    },
    {'taskName': 'Catch up with buddy', 'taskCompleted': false},
    {'taskName': 'Identify Buddy', 'taskCompleted': false},
    {'taskName': 'Machine setup', 'taskCompleted': false},
    {'taskName': 'Meet your Scrum Team', 'taskCompleted': false},
    {'taskName': 'Onboarding Checkpoint with Manager', 'taskCompleted': false},
    {
      'taskName': 'Provide feedback on onboarding process',
      'taskCompleted': false
    },
    {'taskName': 'Request access to UVMS dashboard', 'taskCompleted': false},
    {'taskName': 'Request access to VersionOne (V1)', 'taskCompleted': false},
    {
      'taskName': 'Request to join Product Development Distribution Group',
      'taskCompleted': false
    },
    {'taskName': 'Scrum Team Induction', 'taskCompleted': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBarOverlay(),
      bottomNavigationBar: CustomNavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(25.0),
              child: Text(
                "GENERAL CHECKLIST",
                style: GoogleFonts.quicksand(
                  textStyle: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: fiservColor),
                ),
              ),
            ),
            for (var task in tasks)
              ChecklistTile(
                task: task,
                onChanged: (value) {
                  setState(() {
                    task['taskCompleted'] = value;
                  });
                },
                firestore: widget.firestore,
              ),
          ],
        ),
      ),
    );
  }
}
