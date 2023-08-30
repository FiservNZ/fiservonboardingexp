// import 'package:fiservonboardingexp/util/quiz_components/quiz.dart';
// import 'package:get/get.dart';

// import '../elle_testing/services/firebase_storage_service.dart';

// class QuestionImageController extends GetxController {
//   final allQuizImages = <String>[].obs;
//   //final allQuizzes = <Quiz>[].obs;

//   //timerDuration will have to be changed to a field in the firebase which indicates the quiz length
//   //static const timerDuration = Duration(seconds: 60);

//   @override
//   void onReady() {
//     getAllQuizzes();
//     super.onReady();
//   }

//   Future<void> getAllQuizzes() async {
//     List<String> imgName = ["Harry Potter", "Programming"];
//     try {
//       for (var img in imgName) {
//         final imgUrl = await Get.find<FirebaseStorageService>().getImage(img);
//         allQuizImages.add(imgUrl!);
//         //final imgUrl = await Get.find<FirebaseStorageService>().getImage(quiz.title);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
