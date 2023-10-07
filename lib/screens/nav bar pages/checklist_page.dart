import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/widgets/app_bar_overlay.dart';
import 'package:fiservonboardingexp/util/checklist_tile.dart';
import 'package:flutter/material.dart';
import '../../widgets/nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ChecklistPage extends StatefulWidget {
  final FirebaseFirestore firestore;
  const ChecklistPage({Key? key, required this.firestore}) : super(key: key);

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  Map<String, bool>? checklistData;

  @override
  void initState() {
    super.initState();
    loadChecklistData();
  }

  // Loads the current users (UID) checklist data from firestore.
  Future<void> loadChecklistData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      DocumentSnapshot<Map<String, dynamic>> checklistSnapshot =
          await widget.firestore
              .collection('User')
              .doc(uid)
              .collection('Checklist') // Collection name
              .doc('List') // Document name of the collection
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

  // General checklist UI
  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    return Scaffold(
      backgroundColor: selectedTheme.colorScheme.background,
      appBar: const AppBarOverlay(),
      bottomNavigationBar: const CustomNavBar(),
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
                  textStyle: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: selectedTheme.colorScheme.secondary),
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
