import 'package:fiservonboardingexp/controllers/watch_controller.dart';
import 'package:fiservonboardingexp/screens/task%20pages/watch_card_screen.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/question_screen.dart';
import 'package:fiservonboardingexp/screens/task%20pages/quiz%20screens/splash/spash_screen.dart';
import 'package:fiservonboardingexp/util/mc_testing/module/module_screen.dart';
import 'package:get/get.dart';
import '../controllers/quiz controllers/question_controller.dart';
import '../controllers/quiz controllers/quiz_controller.dart';
import '../controllers/read_controller.dart';
import '../screens/task pages/quiz screens/home_screen.dart';
import '../screens/task pages/quiz screens/introduction.dart';
import '../screens/task pages/quiz screens/quiz_outcome_screen.dart';
import '../screens/task pages/read_card_screen.dart';
import '../screens/task pages/read_page.dart';

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
          page: () => HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuizController());
          }),
        ),
        GetPage(
          name: "/moduleScreen",
          page: () => const ModuleScreen(),
        ),
        GetPage(
          name: "/watchHome",
          page: () => WatchHomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(WatchController());
          }),
        ),
        // GetPage(
        //     name: ReadPage.routeName,
        //     page: () => ReadPage(),
        //     binding: BindingsBuilder(() {
        //       Get.put(ReadController());
        //     })),
        // GetPage(
        //   name: "/readHome",
        //   page: () => ReadHomeScreen(),
        //   binding: BindingsBuilder(() {
        //     Get.put(ReadController());
        //   }),
        // ),

        //idk how to link the screen in the routes
        // GetPage(
        //   name: "/watchScreen",
        //   page: () => const VideoPlayer(),
        //   binding: BindingsBuilder(() {Get.lazyPut(()=>WatchModel())});
        // ),

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
