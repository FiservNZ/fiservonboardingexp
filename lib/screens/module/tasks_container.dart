import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/controllers/load_quiz_tasks.dart';
import 'package:fiservonboardingexp/controllers/load_read_tasks.dart';
import 'package:fiservonboardingexp/controllers/load_watch_tasks.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../firebase references/firebase_refs.dart';
import '../nav bar pages/achievements_page.dart';

class TasksContainer extends StatelessWidget {
  final String watchCategory;
  const TasksContainer({super.key, required this.watchCategory});

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);

    return Scaffold(
      appBar: myAppBar,
      bottomNavigationBar: navBar,
      backgroundColor: selectedTheme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 15.0,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Watch Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        decoration: TextDecoration.underline)
                    .merge(GoogleFonts.quicksand()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(
                child: FutureBuilder<List<Widget>>(
                  future: getWatchTaskWidgets(watchCategory),
                  builder: ((context, snapshot) {
                    detectCompletition(context, watchCategory);
                    _allModuleComplete(context);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: $snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No WATCH TASKS for this Category.',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data![index];
                        },
                      );
                    }
                  }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Read Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        decoration: TextDecoration.underline)
                    .merge(GoogleFonts.quicksand()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(
                child: FutureBuilder<List<Widget>>(
                  future: getReadTaskWidgets(watchCategory),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: $snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No READ TASKS for this Category.',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data![index];
                        },
                      );
                    }
                  }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Quiz Tasks:',
                style: TextStyle(
                        color: selectedTheme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        decoration: TextDecoration.underline)
                    .merge(GoogleFonts.quicksand()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Expanded(
                child: FutureBuilder<List<Widget>>(
                  future: getQuizTaskWidgets(watchCategory),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: $snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                          child: Text(
                        'No QUIZ TASKS for this Category.',
                        style: TextStyle(
                          color: selectedTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ).merge(GoogleFonts.quicksand()),
                      ));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return snapshot.data![index];
                        },
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Update the achievement
  Future<void> _allModuleComplete(
    BuildContext context,
  ) async {
    try {
      // Get task collection
      var tasksCollection = FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser.uid)
          .collection('Tasks');

      QuerySnapshot querySnapshot = await tasksCollection.get();
      bool allTasksCompleted = true;
      // Iterate through each document
      for (var doc in querySnapshot.docs) {
        int currentPoint = doc.get('curPoints');
        int maxPoint = doc.get('maxPoints');
        // when in one of the doc , if the current = max, then it will set "Alltaskcomplete" to false
        if (currentPoint != maxPoint) {
          allTasksCompleted = false;
          break;
        }
      }

      if (allTasksCompleted) {
        // update the achievement when all currentpoint = max point
        final Achievementpage achievementpage = Achievementpage();
        // Delay this achievement popout
        await Future.delayed(const Duration(seconds: 5));
        // ignore: use_build_context_synchronously
        achievementpage.updateAchievement(
            context, "Completed all the modules!");
        debugPrint('All tasks completed! Updating achievement...');
      } else {
        debugPrint('Not all tasks are completed yet.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  Future<void> detectCompletition(BuildContext context, String category) async {
    // Delay this pop out when

    final querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(category)
        .get();

    if (querySnapshot.exists) {
      int maxPoint = querySnapshot.data()?['maxPoints'];
      int currentPoint = querySnapshot.data()?['curPoints'];
      if (maxPoint == currentPoint) {
        // ignore: use_build_context_synchronously
        updateSingleAchievement(context, category);
        debugPrint('$category complete');
      }
    } else {
      debugPrint('Document does not exist.');
    }
  }

  // Update the achievement regard which category get completed
  void updateSingleAchievement(
    BuildContext context,
    String categoryName,
  ) {
    Achievementpage achievementpage = Achievementpage();

    if (categoryName == "Compliance") {
      {
        achievementpage.updateAchievement(context, "Completed Compliance!");
      }
    }
    if (categoryName == "Health & Safety") {
      {
        achievementpage.updateAchievement(
            context, "Completed Health & Safety!");
      }
    }
    if (categoryName == "Customs & Culture") {
      {
        achievementpage.updateAchievement(
            context, "Completed Customs & Culture!");
      }
    }
    if (categoryName == "Orientation") {
      {
        achievementpage.updateAchievement(context, "Completed orientation!");
      }
    }
  }
}
