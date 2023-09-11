import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/widgets/app_bar_overlay.dart';
import 'package:fiservonboardingexp/idk/nav_app_overlay.dart';
import 'package:fiservonboardingexp/util/checklist_tile.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import '../main.dart';

class ChecklistPage extends StatefulWidget {
  final FirebaseFirestore firestore;
  const ChecklistPage({Key? key, required this.firestore}) : super(key: key);

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  Map<String, bool>? checklistData; // Change to nullable type

  @override
  void initState() {
    super.initState();
    loadChecklistData();
  }

  Future<void> loadChecklistData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      DocumentSnapshot<Map<String, dynamic>> checklistSnapshot = await widget
          .firestore
          .collection('User')
          .doc(uid)
          .collection('Checklist')
          .doc('List')
          .get();

      if (checklistSnapshot.exists) {
        // Retrieve checklist from Firestore and set it in the local state
        setState(() {
          checklistData =
              Map<String, bool>.from(checklistSnapshot.data() ?? {});
        });
      }
    } catch (error) {
      print("Error loading checklist data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
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
            if (checklistData != null)
              for (var taskName in checklistData!.keys)
                ChecklistTile(
                  task: {
                    'taskName': taskName,
                    'taskCompleted': checklistData![taskName] ?? false,
                  },
                  onChanged: (value) {
                    // Update checklist locally when a task is checked/unchecked
                    setState(() {
                      checklistData![taskName] = value ?? false;
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
