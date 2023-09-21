// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:fiservonboardingexp/controllers/read_controller.dart';
// import 'package:fiservonboardingexp/util/constants.dart';
// import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
// import 'package:fiservonboardingexp/widgets/quiz%20widgets/content_area.dart';
// import 'package:fiservonboardingexp/screens/task%20pages/read_card.dart';

// class ReadHomeScreen extends GetView<ReadController> {
//   late final String categoryName;

//   ReadHomeScreen({super.key});

//   // A constant representing the route name for this screen
//   static const String routeName = "/readHome";

//   @override
//   Widget build(BuildContext context) {
//     // Get the category name from the arguments passed when navigating to this screen
//     categoryName = Get.arguments as String;

//     return Scaffold(
//       backgroundColor: darkBackgroundColor,
//       body: Column(
//         children: [
//           // A section for displaying the category name and task type
//           Padding(
//             padding: const EdgeInsets.only(top: 50, bottom: 20),
//             child: SizedBox(
//               child: Text(
//                 '${controller.categoryName} Read Tasks',
//                 style: headerFontStyle,
//               ),
//             ),
//           ),

//           // A section for displaying the list of read tasks
//           Expanded(
//             child: ContentArea(
//               addPadding: false,
//               child: Obx(
//                 () => ListView.separated(
//                   padding: UIParameters.mobileScreenPadding,
//                   itemBuilder: (BuildContext context, int index) {
//                     // Display individual read task cards
//                     return ReadCard(
//                       model: controller.allReadTasks[index],
//                     );
//                   },
//                   separatorBuilder: (BuildContext context, int index) {
//                     // Add spacing between read task cards
//                     return const SizedBox(height: 20);
//                   },
//                   itemCount: controller.allReadTasks.length,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
