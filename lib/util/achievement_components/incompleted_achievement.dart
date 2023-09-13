import 'package:flutter/material.dart';
import '../../screens/achievements_page.dart';
import 'achievement_tile.dart';

class IncompletedAchievement extends StatelessWidget {
  final Achievementpage _achievementpage = Achievementpage();

  IncompletedAchievement({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: detectIncompletedAchi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
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
              const SizedBox(height: 3),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> detectIncompletedAchi() async {
    List<Map<String, dynamic>> contentInAchv = [];

    // Invoke fetchAndStoreAchievement method to retrieve the latest achievement data.
    await _achievementpage.fetchAndStoreAchievement(contentInAchv);

    return contentInAchv;
  }
}
