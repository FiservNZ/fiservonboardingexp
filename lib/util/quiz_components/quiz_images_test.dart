// import 'package:fiservonboardingexp/util/quiz_components/question_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:get/state_manager.dart';

// import 'question_image_controller.dart';

// class QuizImagesTest extends StatelessWidget {
//   const QuizImagesTest({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     QuestionImageController questionController =
//         Get.put(QuestionImageController());

//     return Scaffold(
//       body: Obx(() => ListView.separated(
//           itemBuilder: (BuildContext context, int index) {
//             return ClipRRect(
//               child: SizedBox(
//                 height: 200,
//                 width: 200,
//                 child: FadeInImage(
//                     image:
//                         NetworkImage(questionController.allQuizImages[index]),
//                     placeholder:
//                         const AssetImage("assests/images/Fiserv_logo.png")),
//               ),
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) {
//             return const SizedBox(height: 20);
//           },
//           itemCount: questionController.allQuizImages.length)),
//     );
//   }
// }
