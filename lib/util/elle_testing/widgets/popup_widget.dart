import 'package:fiservonboardingexp/util/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/quiz_model.dart';

class Popups {
  static final Popups singleton = Popups._internal();

  Popups._internal();

  factory Popups() {
    return singleton;
  }

  Widget showPopup({required VoidCallback onTap}) {
    return AlertDialog(
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Hi",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text("Hi welcome to the quizzes")
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: onTap, child: const Text("Start")),
            TextButton(onPressed: onTap, child: const Text("Cancel")),
          ],
        )
      ],
    );
  }

  // Widget showPopup({required VoidCallback onTap}) {
  //   return
  // }

  // @override
  // Widget build(BuildContext context) {
  //   throw AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  //     title: Text(model.title),
  //     content: Text(model.description),
  //     actions: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           // On press of the button, the pop up window should close
  //           TextButton(
  //             child: const Text('Close'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           // On press of the button, should be taken to weekonepage.dart
  //           TextButton.icon(
  //               style: TextButton.styleFrom(
  //                 backgroundColor: Colors.white,
  //               ),
  //               icon: Image.asset(
  //                 'assets/icon/start-button.png',
  //                 width: 60,
  //                 height: 60,
  //               ),
  //               label: const SizedBox.shrink(),
  //               onPressed: () async {}),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //Get.toNamed(QuizQuestionScreen.routeName, arguments: quiz);
}
