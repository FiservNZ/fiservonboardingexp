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

    int currentEXP = userMap['EXP'] ?? 0;
    int maxEXP = userMap['MaxEXP'] ?? 100;
    int level = userMap['Level'] ?? 0;

    currentEXP += expToAdd;

    if (currentEXP >= maxEXP) {
      level++;
      maxEXP *= 2;
    }

    await userDocRef
        .update({'EXP': currentEXP, 'Level': level, 'MaxEXP': maxEXP});
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
            final maxEXP = userDocument['MaxEXP'] ?? 100;

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
                          color: Color(0xFFFF6600),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        expText,
                        style: const TextStyle(
                          color: FiservColor,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: barwidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: LinearProgressIndicator(
                      value: currentEXP / maxEXP,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFF6600),
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
