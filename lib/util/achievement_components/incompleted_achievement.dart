import 'package:flutter/material.dart';
import '../../screens/achievements_page.dart';
import 'incomplete_util.dart';

class IncompletedAchievement extends StatelessWidget {
  final Achievementpage _achievementpage = Achievementpage();

  IncompletedAchievement({super.key});
  final List SubiconList = [
    'assets/icon/achievement/First time login!.png',
    'assets/icon/achievement/Unlocked all themes!.png',
    'assets/icon/achievement/Submitted feedback!.png',
    'assets/icon/achievement/Changed Icon!.png',
    'assets/icon/achievement/Completing checklist!.png',
    'assets/icon/achievement/Completed orientation!.png',
    'assets/icon/achievement/Completed Compliance!.png',
    'assets/icon/achievement/Completed Health & Safety!.png',
    'assets/icon/achievement/Completed Technical Training!.png',
    'assets/icon/achievement/Completed Customs & Culture!.png',
    'assets/icon/achievement/Completed all the modules!.png',
    'assets/icon/achievement/Unlocked all icons!.png',
  ];
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
                height: 350,
                // color: Colors.red,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: incompletedAchievements.length,
                  itemBuilder: (context, index) {
                    return IncompleteAchv(
                      title: incompletedAchievements[index]['name'],
                      iconName: SubiconList[index],
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
