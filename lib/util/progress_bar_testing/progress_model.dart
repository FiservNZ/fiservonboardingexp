import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';

class ProgressModel {
  final String id;
  int currProgress;
  int maxProgress;
  // Store task IDs as an array

  ProgressModel({
    required this.currProgress,
    required this.maxProgress,
    required this.id,
  });
}

Future<List<ProgressModel>> getAllTasks() async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;

    if (currentUser != null) {
      final String userId = currentUser.uid;
      final DocumentReference<Map<String, dynamic>> userDocRef =
          FirebaseFirestore.instance.collection('User').doc(userId);
      final QuerySnapshot<Map<String, dynamic>> taskQuerySnapshot =
          await userDocRef.collection('Tasks').get();

      final List<ProgressModel> allTasks =
          taskQuerySnapshot.docs.map((document) {
        return ProgressModel(
          id: document.id,
          currProgress: document['currProgress'],
          maxProgress: document['maxProgress'],
        );
      }).toList();

      return allTasks;
    } else {
      throw Exception('User not authenticated.');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
