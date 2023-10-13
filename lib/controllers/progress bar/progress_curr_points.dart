import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/model/task_category_model.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class PointsUpdater {
  static Future<void> getCurrentPoints(String categoryName) async {
    print(categoryName);
    int noOfcompletedTasks = 0;

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

        final int maxPoints = category.maxPoints;

        // Iterate through subcollections: Quiz, Read, and Watch
        for (String subcollection in ["Quiz", "Read", "Watch"]) {
          final QuerySnapshot subcollectionSnapshot = await categoryDocRef
              .collection(subcollection)
              .where('isDone', isEqualTo: true)
              .get();

          noOfcompletedTasks += subcollectionSnapshot.docs.length;
        }

        // Check if newPoints doesn't exceed maxPoints
        if (noOfcompletedTasks <= maxPoints) {
          // Update the "curPoints" field in Firestore
          await categoryDocRef.update({'curPoints': noOfcompletedTasks});
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
}
