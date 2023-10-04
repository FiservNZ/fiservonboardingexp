import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';

Future<void> getNumberOfTasks(String categoryName) async {
  int numberOfTasks = 0;

  try {
    final DocumentReference categoryDocRef = FirebaseFirestore.instance
        .collection('User')
        .doc(currentUser.uid)
        .collection('Tasks')
        .doc(categoryName);

    final DocumentSnapshot snapshot = await categoryDocRef.get();

    // Check if the category document exists
    if (snapshot.exists) {
      final subCollectionNames = ["Quiz", "Read", "Watch"];

      // Loop through the subcollections and count the documents within each
      for (final subCollectionName in subCollectionNames) {
        final subCollection =
            await categoryDocRef.collection(subCollectionName).get();

        // Count the documents within the subcollection
        numberOfTasks += subCollection.docs.length;
      }

      // Update the 'maxPoints' field in the category document
      await categoryDocRef.update({'maxPoints': numberOfTasks});
    }
  } catch (e) {
    print('Error fetching watch tasks: $e');
  }
}
