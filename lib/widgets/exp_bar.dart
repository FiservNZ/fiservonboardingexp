import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase references/firebase_refs.dart';

class ExpBar extends StatelessWidget {
  final double barwidth;
  const ExpBar({
    super.key,
    required this.barwidth,
  });

  //Method to add exp and handle level up
  Future<void> addExperience(int expToAdd) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    final userDocRef = userColRef.doc(currentUser?.uid);
    final userDoc = await userDocRef.get();
    final userMap = userDoc.data() as Map<String, dynamic>;

    var currentEXP = userMap['EXP'] ?? 0;
    var maxEXP = userMap['MaxEXP'] ?? 100;
    int level = userMap['Level'] ?? 0;

    if (level < 9) {
      currentEXP += expToAdd; //
      if (currentEXP >= maxEXP) {
        level++;
        currentEXP -= maxEXP;
        maxEXP += 150;
        // currentEXP = 0;
      }
    } else if (level == 9 && currentEXP <= maxEXP) {
      currentEXP += expToAdd;
      if (currentEXP >= maxEXP) {
        currentEXP = maxEXP;
      }
    } else if (level > 9) {
      level = 9;
    }
    await userDocRef
        .update({'EXP': currentEXP, 'Level': level, 'MaxEXP': maxEXP});
  }

  // Get the Level
  Future<int> get level async {
    final userDocRef = userColRef.doc(currentUser.uid);
    final userDoc = await userDocRef.get();
    final userMap = userDoc.data() as Map<String, dynamic>;
    return userMap['Level'] ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);
    // Refactor this code in enhancement phase, cant not pull the instance from Ref
    final currentUser = fireAuth.currentUser!;
    return SizedBox(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc(currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final userDocument = snapshot.data!.data() as Map<String, dynamic>;
            final level = userDocument['Level'] ?? 1;
            final currentEXP = userDocument['EXP'] ?? 0;
            final maxEXP = (userDocument['MaxEXP'] ?? 100).toInt();

            final levText = 'LEVEL $level';
            final expText = '$currentEXP/$maxEXP';

            return Column(
              children: [
                SizedBox(
                  width: barwidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        levText,
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts
                            .quicksand()), // Merge styles with GoogleFonts
                      ),
                      Text(
                        expText,
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts
                            .quicksand()), // Merge styles with GoogleFonts
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                SizedBox(
                  width: barwidth,
                  height: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      value: currentEXP / maxEXP,
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
            return const Text('No data available');
          }
        },
      ),
    );
  }
}
