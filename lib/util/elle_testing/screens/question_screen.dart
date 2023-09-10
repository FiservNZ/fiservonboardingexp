import 'package:fiservonboardingexp/util/elle_testing/controllers/animation_controller.dart';
import 'package:fiservonboardingexp/util/elle_testing/firebase_ref/loading_status.dart';
import 'package:fiservonboardingexp/util/elle_testing/themes/ui_parameters.dart';
import 'package:fiservonboardingexp/util/elle_testing/widgets/background_decoration.dart';
import 'package:fiservonboardingexp/util/elle_testing/widgets/content_area.dart';
import 'package:fiservonboardingexp/util/elle_testing/widgets/question_placeholder.dart';
import 'package:fiservonboardingexp/widgets/answer_option_tiles.dart';
import 'package:fiservonboardingexp/widgets/quiz_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart';
import '../controllers/question_controller.dart';
import '../widgets/progressBar.dart';
//import 'quiz_body.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({Key? key}) : super(key: key);
  static const String routeName = "/questionScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const QuizAppBar(
        leadingWidget: ProgressBar(),
        //titleWidget: Text("timer bar pos"),
      ),
      body: BackgroundDecoration(
        child: Obx(() => Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  const Expanded(
                      child: ContentArea(child: QuestionPlaceholder())),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    child: ContentArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Text(
                              controller.currentQuestion.value!.question,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            GetBuilder<QuestionController>(
                                // id allows for the allowing the package to know which GetBuilder<QuestionController> we want updated
                                id: 'answers_list',
                                builder: (context) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final option = controller
                                            .currentQuestion
                                            .value!
                                            .options![index];
                                        return AnswerOptionTiles(
                                          answerOption:
                                              '${option.identifier}. ${option.answer}',
                                          onTap: () {
                                            controller.selectedAnswer(
                                                option.identifier);
                                          },
                                          isSelected: option.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(height: 10),
                                      itemCount: controller.currentQuestion
                                          .value!.options!.length);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ColoredBox(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: UIParameters.mobileScreenPadding,
                    child: Row(
                      children: [
                        Visibility(
                          visible: controller.isFirstQuestion,
                          child: SizedBox(
                            width: 55,
                            height: 55,
                            child: TextButton(
                                onPressed: () {
                                  controller.prevQuestion();
                                },
                                child: const Icon(Icons.arrow_back_ios_new)),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                              visible: controller.loadingStatus.value ==
                                  LoadingStatus.completed,
                              child: TextButton(
                                  onPressed: () {
                                    controller.isLastQuestion
                                        ? Container()
                                        : controller.nextQuestion();
                                  },
                                  child: controller.isLastQuestion
                                      ? const Text('Submit Answers',
                                          selectionColor: Colors.black)
                                      : const Text('Next',
                                          selectionColor: Colors
                                              .black) //const Icon(Icons.arrow_forward_ios),
                                  )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

// child: Center(child: Text("quiz screen"),)
