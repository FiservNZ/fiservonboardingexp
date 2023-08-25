import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpBar extends StatelessWidget {
  final double barwidth;
  const ExpBar({
    super.key,
    required this.barwidth,
  });

  //Method to add exp and handle level up
  Future<void> addExperience(int expToAdd) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userCollection = FirebaseFirestore.instance.collection('User');

    final userDocRef = userCollection.doc(currentUser.uid);
    final userDoc = await userDocRef.get();
    final userMap = userDoc.data() as Map<String, dynamic>;

    var currentEXP = userMap['EXP'] ?? 0;
    var maxEXP = userMap['MaxEXP'] ?? 100;
    int level = userMap['Level'] ?? 0;

    if (level < 9) {
      currentEXP += expToAdd;
      if (currentEXP >= maxEXP) {
        level++;
        maxEXP += 150;
        currentEXP = 0;
      }
    } else if (level == 9 && currentEXP <= maxEXP) {
      currentEXP += expToAdd;
      if (currentEXP >= maxEXP) {
        currentEXP = maxEXP;
      }
    }
    await userDocRef
        .update({'EXP': currentEXP, 'Level': level, 'MaxEXP': maxEXP});
  }

  // Get the Level
  Future<int> get level async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userCollection = FirebaseFirestore.instance.collection('User');

    final userDocRef = userCollection.doc(currentUser.uid);
    final userDoc = await userDocRef.get();
    final userMap = userDoc.data() as Map<String, dynamic>;
    return userMap['Level'] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userCollection = FirebaseFirestore.instance.collection('User');

    return SizedBox(
      child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userCollection.doc(currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final userDocument = snapshot.data!.data() as Map<String, dynamic>;
            final level = userDocument['Level'] ?? 0;
            final currentEXP = userDocument['EXP'] ?? 0;
            final maxEXP = (userDocument['MaxEXP'] ?? 100).toInt();

            final levText = 'LEVEL $level';
            final expText = '$currentEXP/$maxEXP';

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: barwidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        levText,
                        style: const TextStyle(
                          color: FiservColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        expText,
                        style: const TextStyle(
                          color: FiservColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
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
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        FiservColor,
                      ),
                      backgroundColor: Colors.grey,
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

// ignore: constant_identifier_names
const FiservColor = Color(0xFFFF6600);
