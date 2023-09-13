import 'package:fiservonboardingexp/firebase_references/firebase_refs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../screens/achievements_page.dart';
import 'achievement_tile.dart';

class IncompletedAchievement extends StatelessWidget {
  final Achievementpage _achievementpage = Achievementpage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DetectIncompletedAchi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> contentInAchv = snapshot.data!;

          // Filter out achievements with the 'IsComplete' value set to false.
          List<Map<String, dynamic>> incompletedAchievements = contentInAchv
              .where((achievement) => achievement['IsComplete'] == false)
              .toList();

          return Column(
            children: [
              Container(
                width: 400,
                height: 250,
                color: Colors.red,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: incompletedAchievements.length,
                  itemBuilder: (context, index) {
                    return Achievement(
                      size: 3,
                      title: incompletedAchievements[index]['name'],
                      iconName: incompletedAchievements[index]['iconData'],
                      award: '',
                      isCompleted: incompletedAchievements[index]['IsComplete'],
                    );
                  },
                ),
              ),
              SizedBox(height: 3),
            ],
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> DetectIncompletedAchi() async {
    List<Map<String, dynamic>> contentInAchv = [];

    // Invoke fetchAndStoreAchievement method to retrieve the latest achievement data.
    await _achievementpage.fetchAndStoreAchievement(contentInAchv);

    return contentInAchv;
  }
}
