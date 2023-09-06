import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/util/elle_testing/screens/question_screen.dart';
import 'package:fiservonboardingexp/util/elle_testing/widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 65, color: Colors.black),
              const SizedBox(height: 40),
              Text(
                "This is a quiz app.",
                style: fontStyle,
              ),
              const SizedBox(height: 40),
              AppCircleButton(
                onTap: () => Get.offAndToNamed("/home"),
                child: const Icon(Icons.arrow_forward, size: 35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
