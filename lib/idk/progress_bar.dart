// import 'package:fiservonboardingexp/controllers/quiz%20controllers/animation_controller.dart';
// import 'package:fiservonboardingexp/util/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// class QuizProgressBar extends StatelessWidget {
//   // quizDuration will need to be linked to a field in firebase
//   const QuizProgressBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     ThemeData selectedTheme = getSelectedTheme(context);
//     double quizDuration = 60.0;
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         height: 35,
//         decoration: BoxDecoration(
//             border: Border.all(
//                 color: const Color.fromARGB(255, 75, 74, 74), width: 3),
//             borderRadius: BorderRadius.circular(50)),
//         child: GetBuilder<QuizAnimationController>(
//             init: QuizAnimationController(),
//             builder: (controller) {
//               //print(controller.animation.value);
//               return Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: LayoutBuilder(
//                       builder: (context, constraints) => Container(
//                         width: constraints.maxWidth * 0.5,
//                         //width: constraints.maxWidth * controller.animation.value,
//                         decoration: BoxDecoration(
//                             gradient: const LinearGradient(
//                               colors: <Color>[
//                                 Color(0xFF000270),
//                                 Color(0xFF230485),
//                                 Color(0xFF3c0799),
//                                 Color(0xFF540aae),
//                                 Color(0xFF6c0dc3),
//                                 Color(0xFF850ed7),
//                                 Color(0xFF9e0deb),
//                                 Color(0xFFb908ff),
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(50)),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0,
//                     right: 16.0,
//                     bottom: 0,
//                     child: Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 2.0),
//                         child: Row(
//                           children: [
//                             Text(
//                               // quizDuration usage
//                               "$quizDuration",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: selectedTheme.colorScheme.primary),
//                               //"${(controller.animation.value * quizDuration).round()} sec",
//                               textAlign: TextAlign.right,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             }),
//       ),
//     );
//   }
// }
