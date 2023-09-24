import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/model/task_category_model.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

// Define a function to update points for a specific task category
Future<void> addPointsToProgress(String categoryName) async {
  print(categoryName);

  try {
    // Get a reference to the task category document using categoryName
    final DocumentReference categoryDocRef = FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(categoryName);

    // Get the document snapshot
    final DocumentSnapshot snapshot = await categoryDocRef.get();

    if (snapshot.exists) {
      // Access the document data directly
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Create a TaskCategoryModel using the retrieved data
      TaskCategoryModel category = TaskCategoryModel(
        id: categoryName, // Use categoryName as the ID
        title: data['title'],
        curPoints: data['curPoints'],
        maxPoints: data['maxPoints'],
      );

      final int curPoints = category.curPoints;
      final int maxPoints = category.maxPoints;

      // Calculate new progress
      final int newPoints = curPoints + 1;

      // Check if newPoints doesn't exceed maxPoints
      if (newPoints <= maxPoints) {
        // Update the "curPoints" field in Firestore
        await categoryDocRef.update({'curPoints': newPoints});
        logger.d('Points updated successfully.');
      } else {
        logger.w('Points cannot exceed maxPoints.');
      }
    } else {
      logger.w('Task category does not exist.');
    }
  } catch (e, stackTrace) {
    logger.e('Error updating points: $e', error: e, stackTrace: stackTrace);
  }
}
