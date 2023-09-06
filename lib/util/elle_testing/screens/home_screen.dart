import 'package:fiservonboardingexp/util/elle_testing/screens/question_card.dart';
import 'package:fiservonboardingexp/util/elle_testing/themes/ui_parameters.dart';
import 'package:fiservonboardingexp/util/elle_testing/widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.find();
    return Scaffold(
      body: ContentArea(
        addPadding: false,
        child: Obx(() => ListView.separated(
            padding: UIParameters.mobileScreenPadding,
            itemBuilder: (BuildContext context, int index) {
              return QuestionCard(
                model: quizController.allQuizzes[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 20);
            },
            itemCount: quizController.allQuizzes.length)),
      ),
      //itemCount: quizController.allQuizzes.length)),
    );
  }
}
