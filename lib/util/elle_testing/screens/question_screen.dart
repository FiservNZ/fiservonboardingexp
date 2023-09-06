import 'package:fiservonboardingexp/util/elle_testing/controllers/animation_controller.dart';
import 'package:fiservonboardingexp/util/elle_testing/widgets/background_decoration.dart';
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
      body: BackgroundDecoration(
        child: Obx(() => Text(
            Get.find<QuestionController>().currentQuestion.value!.question)),
      ),
    );
  }
}
