import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

//Reference get firebaseStorage => FirebaseStorage.instance.ref();

class FirebaseStorageService extends GetxService {
  final storageRef = FirebaseStorage.instance.ref();

  // getStorageRef(String? imgName) async {
  //   // Create a storage reference from our app
  //   final storageRef = FirebaseStorage.instance.ref();

  //   // Create a reference with an initial file path and name
  //   final pathReference = storageRef.child("quiz_images/Harry Potter.png");
  //   ;

  //   final folderReference = storageRef.child("quiz_images");

  //   // Create a reference to a file from a Google Cloud Storage URI
  //   final gsReference = FirebaseStorage.instance.refFromURL(
  //       "gs://onboardingdatabase.appspot.com/quiz_images/Harry Potter.png");

  //   // Create a reference from an HTTPS URL
  //   // Note that in the URL, characters are URL escaped!
  //   final httpsReference = FirebaseStorage.instance.refFromURL(
  //       "https://firebasestorage.googleapis.com/v0/b/onboardingdatabase.appspot.com/o/quiz_images%2FHarry%20Potter.png?alt=media&token=739056ab-7412-4556-b1a1-ef1d83d82da0");

  //   //final imageUrl = await storageRef.child("quiz_images/Harry Potter.png").getDownloadURL();
  //   final imageUrl = await folderReference
  //       .child("${imgName?.toLowerCase()}.png")
  //       .getDownloadURL();

  //   return imageUrl;
  // }

  Future<String?> getStorageRef(String? imgName) async {
    // Create a storage reference from our app
    //final storageRef = FirebaseStorage.instance.ref();

    // Create a reference with an initial file path and name
    // final pathReference = storageRef.child("quiz_images/Harry Potter.png");

    final folderReference = storageRef.child("quiz_images");

    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = folderReference.child("$imgName.png");
      var imgUrl = await urlRef.getDownloadURL();
      print(urlRef);

      return imgUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

//   Future<String?> getImage(String? imgName) async {
//     if (imgName == null) {
//       return null;
//     }
//     try {
//       var urlRef = firebaseStorage
//           .child("quiz_images")
//           .child("${imgName.toLowerCase()}.png");
//       var imgUrl = await urlRef.getDownloadURL();
//       print(urlRef);

//       return imgUrl;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
}
