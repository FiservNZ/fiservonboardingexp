import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.find();
    return Scaffold(
      body: Obx(() => ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              //key: Key('image_$index'),
              child: SizedBox(
                height: 200,
                width: 200,
                child: CachedNetworkImage(
                  imageUrl: quizController.allQuizzes[index].imageUrl ?? "",
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/Fiserv_logo.png"),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
          itemCount: quizController.allQuizzes.length)),
      //itemCount: quizController.allQuizzes.length)),
    );
  }
}
