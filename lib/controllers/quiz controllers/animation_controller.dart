import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiservonboardingexp/model/quiz_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../firebase references/services/firebase_storage_service.dart';

// Using GetX for progress bar animation state.
class QuizAnimationController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  //timerDuration will have to be changed to a field in the firebase which indicates the quiz length
  static const timerDuration = Duration(seconds: 60);

  Animation get animation => _animation;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: timerDuration, vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward();

    super.onInit();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /*void selectedAnswer(String? answer){
    currentQuestion.value!.
  }*/
}
