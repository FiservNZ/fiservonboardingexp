import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/model/task_category_model.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/progress_max_points.dart';
import 'package:fiservonboardingexp/util/progress_curr_points.dart';
import 'package:flutter/material.dart';

import '../screens/achievements_page.dart';

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
          return const LinearProgressIndicator();
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
  // void _updateAchievement(BuildContext context, String categoryName,
  //     int currentPoint, int maxPoint) {
  //   Achievementpage achievementpage = Achievementpage();
  //   if (categoryName == "Compliance") {
  //     if (currentPoint == maxPoint) {
  //       achievementpage.updateAchievement(context, "Completed Compliance!");
  //     }
  //   }
  //   if (categoryName == "Health & Safety") {
  //     if (currentPoint == maxPoint) {
  //       achievementpage.updateAchievement(
  //           context, "Completed Health & Safety!");
  //     }
  //   }
  //   if (categoryName == "Customs & Culture") {
  //     if (currentPoint == maxPoint) {
  //       achievementpage.updateAchievement(
  //           context, "Completed Customs & Culture!");
  //     }
  //   }
  //   if (categoryName == "Orientation") {
  //     if (currentPoint == maxPoint) {
  //       achievementpage.updateAchievement(context, "Completed orientation!");
  //     }
  //   }
  // }

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
          return const LinearProgressIndicator();
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
        // _updateAchievement(
        //     context, taskCategory, category.curPoints, category.maxPoints);

        final double progressPercentage =
            (category.curPoints / category.maxPoints);

        // Displays the progress indicator
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: 1.15,
              child: SizedBox(
                width: 50, // Adjust the width as needed
                height: 30, // Adjust the height as needed
                child: CircularProgressIndicator(
                  value: progressPercentage,
                  strokeWidth: 4.0,
                  color: selectedTheme.colorScheme.primary,
                  backgroundColor: selectedTheme.colorScheme.surface,
                ),
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
        );
      },
    );
  }
}


// child: Stack(
//   alignment: Alignment.center,
//   children: [
//     Transform.scale(
//       scale: 1.15,
//       child: SizedBox(
//         width: 100, // Adjust the width as needed
//         height: 10, // Adjust the height as needed
//         child: LinearProgressIndicator(
//           value: progressPercentage,
//           valueColor: AlwaysStoppedAnimation<Color>(
//             selectedTheme.colorScheme.primary,
//           ),
//           backgroundColor: selectedTheme.colorScheme.surface,
//         ),
//       ),
//     ),
//     Text(
//       '${category.curPoints} / ${category.maxPoints}',
//       style: TextStyle(
//         color: selectedTheme.colorScheme.primary,
//         fontSize: 12,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   ],
// ),