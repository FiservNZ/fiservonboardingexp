import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';

Future<int> getExpLevel() async {
  try {
    final DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('User').doc(currentUser.uid);

    final DocumentSnapshot snapshot = await userDocRef.get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      // Check if 'level' field exists in the document data
      if (data.containsKey('Level')) {
        int level = data['Level'] as int;
        return level;
      } else {
        // Throw an exception if 'level' field doesn't exist in the document
        throw Exception("'level' field not found in the document");
      }
    } else {
      // Throw an exception if the document doesn't exist
      throw Exception("Document does not exist");
    }
  } catch (e) {
    // Rethrow the error if needed
    rethrow;
  }
}

bool isRainforestThemeLocked(int level) {
  // Define the minimum level required to unlock the Rainforest Theme
  const int minLevelToUnlockRainforest = 3;

  // Check if the user's level is less than the minimum required level for Rainforest Theme
  return level < minLevelToUnlockRainforest;
}

bool isPastelThemeLocked(int level) {
  // Define the minimum level required to unlock the Pastel Theme
  const int minLevelToUnlockPastel = 6;

  // Check if the user's level is less than the minimum required level for Pastel Theme
  return level < minLevelToUnlockPastel;
}

bool isBeachThemeLocked(int level) {
  // Define the minimum level required to unlock the Beach Theme
  const int minLevelToUnlockBeach = 9;

  // Check if the user's level is less than the minimum required level for Beach Theme
  return level < minLevelToUnlockBeach;
}
