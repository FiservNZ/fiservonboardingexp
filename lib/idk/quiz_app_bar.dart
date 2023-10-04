// import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
// import 'package:flutter/material.dart';

// class QuizAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final Widget? titleWidget;
//   final Widget? timerBar;
//   final Widget? leadingWidget;
//   const QuizAppBar({
//     super.key,
//     this.timerBar,
//     this.title = '',
//     this.titleWidget,
//     this.leadingWidget,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: mobileScreenPadding, vertical: mobileScreenPadding),
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: timerBar == null
//                   ? Center(
//                       child: Text(title,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: Colors.white)))
//                   : Center(child: titleWidget),
//             ),
//             Row(
//               children: [
//                 leadingWidget ??
//                     Transform.translate(
//                       offset: const Offset(-14, 0),
//                       child: const BackButton(),
//                     ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size(double.maxFinite, 80);
// }
