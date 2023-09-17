import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

// Define a function to update points for a specific task category
Future<void> addPointsToProgress(String categoryName, int points) async {
  try {
    // Get a reference to the task category document using categoryName
    final DocumentReference categoryDocRef = FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(categoryName);

    // Get the current task category document data
    final DocumentSnapshot<Object?> snapshot = await categoryDocRef.get();

    if (snapshot.exists) {
      final int curPoints = snapshot['curPoints'] as int;
      final int maxPoints = snapshot['maxPoints'] as int;

      // Calculate new progress
      final int newPoints = curPoints + points;

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
