import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class AchievementTracker extends StatelessWidget {
  const AchievementTracker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final achievementColRef =
        userColRef.doc(currentUser.uid).collection("Achievement");

    return SizedBox(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: achievementColRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            int totalAchv = snapshot.data?.docs.length ?? 0;
            int completedAchv = snapshot.data?.docs
                    .where((doc) => doc['IsComplete'] == true)
                    .length ??
                0;
            return Column(
              children: [
                Container(
                  width: 175,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 66, 54, 133),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_border_outlined,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Achievements",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "$completedAchv/$totalAchv",
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
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
