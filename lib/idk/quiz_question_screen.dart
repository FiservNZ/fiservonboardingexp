// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../util/constants.dart';
// import '../../../../controllers/quiz controllers/question_controller.dart';

// class QuizQuestionScreen extends GetView<QuestionController> {
//   const QuizQuestionScreen({Key? key}) : super(key: key);
//   static const String routeName = "/quizQuestionScreen";

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         backgroundColor: const Color.fromARGB(255, 46, 46, 46),
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           actions: [
//             TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Skip',
//                   style: TextStyle(color: darkTextColor),
//                 ))
//           ],
//         ),
//         body: Stack(
//           children: [
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     Text.rich(
//                       TextSpan(
//                         text: "Question 1",
//                         style: GoogleFonts.quicksand(
//                             fontSize: bodyFontSize,
//                             color: const Color.fromARGB(255, 156, 156, 156)),
//                         children: [
//                           TextSpan(
//                             text: " out of ",
//                             style:
//                                 GoogleFonts.quicksand(fontSize: bodyFontSize),
//                           ),
//                           TextSpan(
//                             text: "10",
//                             style:
//                                 GoogleFonts.quicksand(fontSize: bodyFontSize),
//                           )
//                         ],
//                       ),
//                     ),
//                     const Divider(thickness: 3, indent: 55, endIndent: 55),
//                     const SizedBox(height: 10),
//                     Container(
//                       alignment: Alignment.center,
//                       margin: const EdgeInsets.symmetric(horizontal: 20),
//                       padding: const EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             "data blblb lblbl blblbl blblb lblbl bl blbl blbl blbl blb lbl",
//                             style: darkHeaderFontStyle,
//                             textAlign: TextAlign.center,
//                           ),
//                           //Answer_Tiles(answer: '', isSelected: null, onTap: () {  },),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
