import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addPointsToTask(String taskId, int points) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;

    if (currentUser != null) {
      final String userId = currentUser.uid;
      final DocumentReference<Map<String, dynamic>> userDocRef =
          FirebaseFirestore.instance.collection('User').doc(userId);
      final DocumentReference<Map<String, dynamic>> taskDocRef =
          userDocRef.collection('Tasks').doc(taskId);

      final DocumentSnapshot<Map<String, dynamic>> taskDoc =
          await taskDocRef.get();

      if (taskDoc.exists) {
        final int currProgress = taskDoc['currProgress'] as int;
        final int maxProgress = taskDoc['maxProgress'] as int;

        // Calculate new progress and update the task document
        final int newProgress = currProgress + points;
        if (newProgress < maxProgress) {
          await taskDocRef.update({'currProgress': newProgress});
        }
      } else {
        throw Exception('Task document not found.');
      }
    } else {
      throw Exception('User not authenticated.');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
