import 'package:fiservonboardingexp/controllers/progress%20bar/progress_curr_points.dart';
import 'package:fiservonboardingexp/firebase%20references/firebase_refs.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/extension_question_controller.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/question_controller.dart';
import 'package:fiservonboardingexp/screens/module/module_screen.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/background_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizOutcomeScreen extends GetView<QuestionController> {
  const QuizOutcomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/quizend";

  @override
  Widget build(BuildContext context) {
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

      // Updates the current points after isDone is set to true
      await PointsUpdater.getCurrentPoints(currentCategory);
    }

    fetchData();

    ThemeData selectedTheme = getSelectedTheme(context);
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: selectedTheme.colorScheme.secondary);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundDecoration(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
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
                      style: GoogleFonts.quicksand(
                          color: selectedTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "If this is your first completion, you will recieve ${controller.quizModel.exp} EXP!",
                        style: GoogleFonts.quicksand(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: selectedTheme.colorScheme.primary),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              ColoredBox(
                color: selectedTheme.colorScheme.onBackground,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: ElevatedButton(
                            style: style,
                            onPressed: () {
                              controller.navigateToHome();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Done',
                                selectionColor: Colors.black,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        selectedTheme.colorScheme.onBackground),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
