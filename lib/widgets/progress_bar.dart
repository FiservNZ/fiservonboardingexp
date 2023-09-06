import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  //Method to add points
  Future<void> addPoints(int points) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    final userCollection = FirebaseFirestore.instance.collection('User');

    final userDocRef = userCollection.doc(currentUser.uid);
    final userDoc = await userDocRef.get();
    final userMap = userDoc.data() as Map<String, dynamic>;

    var curPoints = userMap['curPoints'] ?? 0;
    var maxPoints = userMap['maxPoints'] ?? 4;
    bool completed = userMap['categoryCompletion'] ?? false;

    if (curPoints < maxPoints) {
      curPoints += points;
      if (curPoints == maxPoints) {
        completed = true;
      }
    }

    await userDocRef.update({
      'curPoints': curPoints,
      'maxPoints': maxPoints,
      'categoryCompletion': completed
    });
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
            final curPoints = userDocument['curPoints'] ?? 0;
            final maxPoints = (userDocument['maxPoints'] ?? 4).toInt();
            final pointsText = '$curPoints/$maxPoints';

            return Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progress Bar',
                        style: TextStyle(
                          color: fiservColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        pointsText,
                        style: const TextStyle(
                          color: fiservColor,
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
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        fiservColor,
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
