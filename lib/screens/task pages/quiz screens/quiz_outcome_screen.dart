import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/extension_question_controller.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/question_controller.dart';
import 'package:fiservonboardingexp/util/mc_testing/module/module_screen.dart';
import 'package:fiservonboardingexp/util/progress_points.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/background_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizOutcomeScreen extends GetView<QuestionController> {
  const QuizOutcomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/quizend";

  @override
  Widget build(BuildContext context) {
    // Add points to progress bar when it's the users first time completing the task
    if (controller.quizModel.isDone == false) {
      addPointsToProgress(currentCategory);
    }

    // Updates isDone to show the task has been completed.
    Future<void> fetchData() async {
      final querySnapshot = await userColRef
          .doc(currentUser.uid)
          .collection('Tasks')
          .doc(currentCategory)
          .collection('Quiz')
          .where('title', isEqualTo: controller.quizModel.title)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs[0];
        await doc.reference.update({'isDone': true});
      }
    }

    fetchData();

    ThemeData selectedTheme = getSelectedTheme(context);
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: selectedTheme.colorScheme.secondary);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundDecoration(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QuizAppBar(
            //     leadingWidget: const SizedBox(height: 80),
            //     title: controller.correctAnsweredQuestions),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 170),
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('assets/images/successful.png')),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        "Quiz Completed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: selectedTheme.colorScheme.secondary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      controller.correctAnsweredQuestions,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: bodyFontSize,
                          fontWeight: FontWeight.bold,
                          color: selectedTheme.colorScheme.primary),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Thank you for completing the ${controller.quizModel.title} quiz!",
                      style:
                          TextStyle(color: selectedTheme.colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "If this is your first completion, you will recieve ${controller.quizModel.exp} EXP!",
                        style: GoogleFonts.quicksand(
                            fontSize: 13,
                            color: selectedTheme.colorScheme.primary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: selectedTheme.colorScheme.background ?? Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 200, right: 30, left: 20, top: 10),
                //padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 10.0),
                    //   child: Visibility(
                    //     visible: controller.isFirstQuestion,
                    //     child: ElevatedButton(
                    //       style: style,
                    //       onPressed: () {
                    //         controller.tryAgain();
                    //       },
                    //       child: const Padding(
                    //         padding: EdgeInsets.all(10.0),
                    //         child: Text(
                    //           "Try again",
                    //           selectionColor: Colors.black,
                    //           style: TextStyle(color: fiservColor),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: ElevatedButton(
                            style: style,
                            onPressed: () {
                              controller.navigateToHome();
                              //controller.saveQuizResults();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Done',
                                selectionColor: Colors.black,
                                style: TextStyle(
                                    color: selectedTheme.colorScheme.tertiary),
                              ),
                            ),
                          )),
                    ),
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
