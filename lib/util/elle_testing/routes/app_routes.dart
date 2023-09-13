import 'package:fiservonboardingexp/controllers/quiz%20controllers/animation_controller.dart';
import 'package:fiservonboardingexp/controllers/quiz%20controllers/quiz_controller.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/home_screen.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/question_screen.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/quiz_question_screen.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/splash/spash_screen.dart';
import 'package:get/get.dart';

import '../../../controllers/quiz controllers/question_controller.dart';
import '../../../screens/task pages/quiz screens/introduction.dart';
import '../../../screens/task pages/quiz screens/quiz_outcome_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: "/introduction",
          page: () => const IntroductionScreen(),
        ),
        GetPage(
          name: "/home",
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuizController());
          }),
        ),
        // GetPage(
        //   name: QuizQuestionScreen.routeName,
        //   page: () => const QuizQuestionScreen(),
        //   binding: BindingsBuilder(() {
        //     Get.put(QuestionController());
        //   }),
        // ),
        GetPage(
          name: QuestionScreen.routeName,
          page: () => const QuestionScreen(),
          binding: BindingsBuilder(() {
            Get.put<QuestionController>(QuestionController());
          }),
        ),
        GetPage(
          name: QuizOutcomeScreen.routeName,
          page: () => const QuizOutcomeScreen(),
        ),
      ];
}
