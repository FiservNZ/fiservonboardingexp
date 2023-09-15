import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:fiservonboardingexp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase references/firebase_refs.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  // Method to add points to the user's progress
  Future<void> addPoints(int points) async {
    // Fetch the current user's document from Firestore
    final userDocRef = userColRef.doc(currentUser.uid);
    final userDoc = await userDocRef.get();
    final userMap = userDoc.data() as Map<String, dynamic>;

    var curPoints = userMap['curPoints'] ?? 0;
    var maxPoints = userMap['maxPoints'] ?? 4;
    bool completed = userMap['categoryCompletion'] ?? false;

    // Increment the current points and check for completion
    if (curPoints < maxPoints) {
      curPoints += points;
      if (curPoints == maxPoints) {
        completed = true;
      }
    }

    // Update the user's document in Firestore with the new data
    await userDocRef.update({
      'curPoints': curPoints,
      'maxPoints': maxPoints,
      'categoryCompletion': completed
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData selectedTheme = themeProvider.currentTheme;

    return SizedBox(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userColRef.doc(currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while fetching user data
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Display an error message if there's an error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Extract user data from the snapshot
            final userDocument = snapshot.data!.data() as Map<String, dynamic>;
            final curPoints = userDocument['curPoints'] ?? 0;
            final maxPoints = (userDocument['maxPoints'] ?? 4).toInt();
            final pointsText = '$curPoints/$maxPoints';

            // Display the progress bar and points information
            return Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress Bar',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ),
                      Text(
                        pointsText,
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  width: 200,
                  height: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      value: curPoints / maxPoints,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        selectedTheme.colorScheme.secondary,
                      ),
                      backgroundColor: const Color.fromARGB(255, 190, 188, 184),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Show a message when there's no data available
            return const Text('No data available');
          }
        },
      ),
    );
  }
}
