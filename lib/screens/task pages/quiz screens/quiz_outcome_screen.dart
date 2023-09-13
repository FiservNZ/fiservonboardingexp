import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/extension_question_controller.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/question_controller.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/background_decoration.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/quiz_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/quiz themes/ui_parameters.dart';

class QuizOutcomeScreen extends GetView<QuestionController> {
  const QuizOutcomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/quizend";

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: Colors.white);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundDecoration(
        child: Column(
          children: [
            QuizAppBar(
                leadingWidget: const SizedBox(height: 80),
                title: controller.correctAnsweredQuestions),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/successful.png')),
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        "Congratulations!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: fiservColor),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${controller.correctAnsweredQuestions}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: bodyFontSize,
                          fontWeight: FontWeight.bold,
                          color: fiservColor),
                    ),
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: darkBackgroundColor ?? Colors.white,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                //padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Visibility(
                        visible: controller.isFirstQuestion,
                        child: ElevatedButton(
                          style: style,
                          onPressed: () {
                            controller.tryAgain();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Try again",
                              selectionColor: Colors.black,
                              style: TextStyle(color: fiservColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ElevatedButton(
                            style: style,
                            onPressed: () {
                              controller.navigateToHome();
                              //controller.saveQuizResults();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Done',
                                selectionColor: Colors.black,
                                style: TextStyle(color: fiservColor),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
