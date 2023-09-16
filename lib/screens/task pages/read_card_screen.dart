import 'package:fiservonboardingexp/controllers/read_controller.dart';
import 'package:fiservonboardingexp/controllers/watch_controller.dart';
import 'package:fiservonboardingexp/screens/task%20pages/read_card.dart';
import 'package:fiservonboardingexp/screens/task%20pages/watch_card.dart';
import 'package:fiservonboardingexp/util/constants.dart';
import 'package:fiservonboardingexp/themes/quiz%20themes/ui_parameters.dart';
import 'package:fiservonboardingexp/widgets/quiz%20widgets/content_area.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadHomeScreen extends GetView<ReadController> {
  late final String categoryName;
  ReadHomeScreen({super.key});
  static const String routeName = "/readHome";

  @override
  Widget build(BuildContext context) {
    //categoryName = Get.arguments as String;
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Column(
        children: [
          // will need to change to pull the title from whatever category has been chosen.
          //Expanded(
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: SizedBox(
              child: Text(
                'This is where the title will go',
                //'$categoryName Watch Tasks',
                style: headerFontStyle,
              ),
            ),
          ),
          //),
          Expanded(
            child: ContentArea(
              addPadding: false,
              child: Obx(
                () => ListView.separated(
                    padding: UIParameters.mobileScreenPadding,
                    itemBuilder: (BuildContext context, int index) {
                      return ReadCard(
                        model: controller.allReadTasks[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 20);
                    },
                    itemCount: controller.allReadTasks.length),
              ),
            ),
          ),
        ],
      ),

      //itemCount: quizController.allQuizzes.length)),
    );
  }
}
