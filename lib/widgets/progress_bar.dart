import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/model/task_category_model.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/material.dart';
import '../controllers/progress bar/progress_curr_points.dart';
import '../controllers/progress bar/progress_max_points.dart';
import '../screens/nav bar pages/achievements_page.dart';

class ProgressBar extends StatelessWidget {
  final String taskCategory;

  const ProgressBar({Key? key, required this.taskCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = getSelectedTheme(context);

    return FutureBuilder(
      future: _loadData(), // Call the _loadData method first
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Continue with rendering your progress bar based on the data loaded in _loadData().
        return _buildProgressBar(selectedTheme, context);
      },
    );
  }

  Future<void> _loadData() async {
    // Call getNumberOfTasks here before proceeding with other operations
    await getNumberOfTasks(taskCategory);
    await getCurrentPoints(taskCategory);
    // You can add additional operations here if needed
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
      ;
      if (allTasksCompleted) {
        // update the achievement when all currentpoint = max point
        Achievementpage achievementpage = Achievementpage();
        // ignore: use_build_context_synchronously
        achievementpage.updateAchievement(
            context, "Completed all the modules!");
        print('All tasks completed! Updating achievement...');
      } else {
        print('Not all tasks are completed yet.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  Widget _buildProgressBar(ThemeData selectedTheme, BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('User')
          .doc(currentUser.uid)
          .collection('Tasks')
          .doc(taskCategory) // Use title as the document ID
          .get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('No data available for $taskCategory');
        }

        // Accesses the document data directly
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        // Creates a TaskCategoryModel using the retrieved data
        TaskCategoryModel category = TaskCategoryModel(
          id: taskCategory, // Use title as the ID
          title: data['title'],
          curPoints: data['curPoints'],
          maxPoints: data['maxPoints'],
        );

        // update achievement when the category complete
        _allModuleComplete(context);

        final double progressPercentage =
            (category.curPoints / category.maxPoints);

        // Displays the progress indicator
        return Container(
          // child: Column(
          //   children: [
          //     Text(
          //       '${category.curPoints} / ${category.maxPoints}',
          //       style: TextStyle(
          //         color: selectedTheme.colorScheme.primary,
          //         fontSize: 15,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     const SizedBox(height: 3),
          //     SizedBox(
          //       width: 80,
          //       height: 10,
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(5),
          //         child: LinearProgressIndicator(
          //           value: progressPercentage,
          //           valueColor: AlwaysStoppedAnimation<Color>(
          //             selectedTheme.colorScheme.primary,
          //           ),
          //           backgroundColor: selectedTheme.colorScheme.surface,
          //         ),
          //       ),
          //     ),

          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: 1.15,
                child: CircularProgressIndicator(
                  value: progressPercentage,
                  strokeWidth: 4.0,
                  color: selectedTheme.colorScheme.primary,
                  backgroundColor: selectedTheme.colorScheme.surface,
                ),
              ),
              Text(
                '${category.curPoints} / ${category.maxPoints}',
                style: TextStyle(
                  color: selectedTheme.colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
