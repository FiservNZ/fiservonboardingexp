import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/home_screen.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/question_screen.dart';
import 'package:fiservonboardingexp/util/mc_testing/module/module_screen.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/app_circle_button.dart';
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
              const Icon(Icons.star, size: 65, color: fiservColor),
              const SizedBox(height: 40),
              Text(
                "This is a quiz app.",
                style: darkBodyFontStyle,
              ),
              const SizedBox(height: 40),
              AppCircleButton(
                onTap: () => Get.offAndToNamed(ModuleScreen.routeName),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 35,
                  color: fiservColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
