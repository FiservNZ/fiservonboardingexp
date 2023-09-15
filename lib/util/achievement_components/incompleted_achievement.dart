import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../firebase references/firebase_refs.dart';
import '../../screens/achievements_page.dart';
import 'incomplete_util.dart';

class IncompletedAchievement extends StatelessWidget {
  final Achievementpage _achievementpage = Achievementpage();

  IncompletedAchievement({super.key});
  // Update the current user account

  @override
  Widget build(BuildContext context) {
    // Update the current user account
    final currentUser = FirebaseAuth.instance.currentUser;
    final achievementColRef =
        userColRef.doc(currentUser?.uid).collection("Achievement");

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: achievementColRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          //fetch the achievement list
          final List<Map<String, dynamic>> contentInAchv =
              _achievementpage.fetchAndStoreAchievement(snapshot.data!.docs);
          // List<Map<String, dynamic>> contentInAchv = snapshot.data!;

          // Filter out achievements with the 'IsComplete' value set to false.
          List<Map<String, dynamic>> incompletedAchievements = contentInAchv
              .where((achievement) => achievement['IsComplete'] == false)
              .toList();

          return Column(
            children: [
              Container(
                width: 400,
                height: 350,
                // color: Colors.red,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: incompletedAchievements.length,
                  itemBuilder: (context, index) {
                    return IncompleteAchv(
                      title: incompletedAchievements[index]['name'],
                      iconName: incompletedAchievements[index]['subiconData'],
                      award: '',
                      isCompleted: incompletedAchievements[index]['IsComplete'],
                    );
                  },
                ),
              ),
              const SizedBox(height: 3),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
